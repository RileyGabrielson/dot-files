#!/usr/bin/env python3
"""Blocks a turn that leaves newly added code comments in the working tree.

Runs as a Stop hook. With --record-baseline it runs as a SessionStart hook and
stores the starting commit, so comments in commits made during the session are
still caught.
"""
import hashlib
import json
import os
import re
import subprocess
import sys
import time

MAX_BLOCKS = 3
MAX_REPORTED = 25

C = "c"
HASH = "hash"
DASH = "dash"

EXT_STYLE = {
    "go": C, "ts": C, "tsx": C, "js": C, "jsx": C, "mjs": C, "cjs": C, "mts": C,
    "cts": C, "c": C, "h": C, "cc": C, "cpp": C, "hpp": C, "java": C, "kt": C,
    "kts": C, "swift": C, "rs": C, "php": C, "scala": C, "cs": C, "dart": C,
    "proto": C, "css": C, "scss": C, "less": C, "vue": C, "svelte": C,
    "gradle": C, "groovy": C, "zig": C,
    "py": HASH, "rb": HASH, "sh": HASH, "bash": HASH, "zsh": HASH, "pl": HASH,
    "tf": HASH, "tfvars": HASH, "gd": HASH, "ex": HASH, "exs": HASH, "r": HASH,
    "sql": DASH, "lua": DASH, "hs": DASH, "elm": DASH,
}

PRAGMA = {
    C: re.compile(
        r"^\s*(?:"
        r"///?\s*(?:go:|nolint|@ts-|ts-|eslint|prettier-|biome-|oxlint|tslint:|"
        r"jshint|jslint|globals\b|noinspection|istanbul |c8 |v8 |deno-|swagger:|"
        r"revive:|lint:|#region|#endregion|<reference|svelte-ignore )"
        r"|/\*\s*(?:eslint|global|istanbul|prettier|jshint|c8|@ts-|package|"
        r"webpackChunkName)"
        r")"
    ),
    HASH: re.compile(
        r"^\s*(?:#!"
        r"|#\s*(?:type:\s*ignore|noqa|pylint:|mypy:|pyright:|ruff:|fmt:|"
        r"shellcheck |-\*-|nosec|pragma:))"
    ),
    DASH: re.compile(r"^\s*--\s*(?:luacheck:|@|\+\+)"),
}

BLOCK_CONTINUATION = re.compile(r"^\s*\*(?:$|[\s/])")

VENDOR = re.compile(
    r"(^|/)(node_modules|vendor|third_party|\.venv|venv|site-packages|__pycache__"
    r"|dist|build|target|\.next|\.nuxt|coverage|generated|skills/synced|addons)/"
)

TRIPLE_QUOTE = re.compile(r'"""|\'\'\'')


def blank_strings(line):
    out = []
    quote = None
    escaped = False
    for ch in line:
        if quote:
            if escaped:
                escaped = False
            elif ch == "\\":
                escaped = True
            elif ch == quote:
                quote = None
                out.append(ch)
                continue
            out.append(" ")
            continue
        if ch in "\"'`":
            quote = ch
        out.append(ch)
    return "".join(out)


def find_comment(line, style):
    if not line.strip():
        return False
    if PRAGMA[style].match(line):
        return False
    if style == C and BLOCK_CONTINUATION.match(line):
        return True

    masked = blank_strings(line)
    if style == C:
        for marker in ("//", "/*"):
            i = masked.find(marker)
            while i != -1:
                if i == 0 or masked[i - 1] != ":":
                    return True
                i = masked.find(marker, i + 1)
        return False

    marker = "#" if style == HASH else "--"
    i = masked.find(marker)
    while i != -1:
        if i == 0 or masked[:i].strip() == "" or masked[i - 1].isspace():
            return True
        i = masked.find(marker, i + len(marker))
    return False


def style_for(path):
    if VENDOR.search(path):
        return None
    ext = path.rsplit(".", 1)[-1].lower() if "." in path else ""
    return EXT_STYLE.get(ext)


def git(cwd, *args):
    try:
        r = subprocess.run(
            ("git",) + args, cwd=cwd, capture_output=True, text=True, timeout=20
        )
    except (OSError, subprocess.SubprocessError):
        return None
    return r.stdout if r.returncode == 0 else None


def scan_file(cwd, path, style):
    found = []
    in_triple = False
    try:
        with open(os.path.join(cwd, path), encoding="utf-8", errors="replace") as f:
            for n, raw in enumerate(f, 1):
                line = raw.rstrip("\n")
                marks = len(TRIPLE_QUOTE.findall(line))
                if in_triple:
                    if marks % 2:
                        in_triple = False
                    continue
                if marks % 2:
                    in_triple = True
                if find_comment(line, style):
                    found.append((path, n, line.strip()))
    except OSError:
        pass
    return found


def triple_quoted_lines(cwd, path):
    inside = set()
    in_triple = False
    try:
        with open(os.path.join(cwd, path), encoding="utf-8", errors="replace") as f:
            for n, raw in enumerate(f, 1):
                marks = len(TRIPLE_QUOTE.findall(raw.rstrip("\n")))
                if in_triple:
                    inside.add(n)
                    if marks % 2:
                        in_triple = False
                    continue
                if marks % 2:
                    in_triple = True
    except OSError:
        return set()
    return inside


def uses_triple_quotes(path, style):
    return style == HASH and path.rsplit(".", 1)[-1].lower() == "py"


def diff_additions(cwd, baseline, since):
    found = []
    diff = git(cwd, "diff", "-U0", "--no-color", "--no-ext-diff", baseline, "--", ".")
    if diff:
        path = None
        style = None
        lineno = 0
        skip_lines = set()
        for line in diff.splitlines():
            if line.startswith("+++ "):
                path = line[6:] if line.startswith("+++ b/") else None
                style = style_for(path) if path else None
                skip_lines = (
                    triple_quoted_lines(cwd, path)
                    if style and uses_triple_quotes(path, style)
                    else set()
                )
            elif line.startswith("@@"):
                m = re.match(r"@@ -\S+ \+(\d+)", line)
                lineno = int(m.group(1)) if m else 0
            elif line.startswith("+") and not line.startswith("+++"):
                if (
                    style
                    and lineno not in skip_lines
                    and find_comment(line[1:], style)
                ):
                    found.append((path, lineno, line[1:].strip()))
                lineno += 1

    if since is None:
        return found

    untracked = git(cwd, "ls-files", "--others", "--exclude-standard")
    for path in (untracked or "").splitlines():
        style = style_for(path)
        if not style:
            continue
        try:
            if os.path.getmtime(os.path.join(cwd, path)) < since:
                continue
        except OSError:
            continue
        found.extend(scan_file(cwd, path, style))
    return found


def state_path(session_id, cwd, suffix):
    root = os.path.join(os.environ.get("TMPDIR", "/tmp"), "claude-no-comments")
    os.makedirs(root, exist_ok=True)
    key = hashlib.sha1(f"{session_id}:{cwd}".encode()).hexdigest()[:16]
    return os.path.join(root, f"{key}.{suffix}")


def read_state(path, default=""):
    try:
        with open(path) as f:
            return f.read().strip()
    except OSError:
        return default


def write_state(path, value):
    try:
        with open(path, "w") as f:
            f.write(str(value))
    except OSError:
        pass


def main():
    try:
        payload = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        return 0

    cwd = payload.get("cwd") or os.getcwd()
    session_id = payload.get("session_id", "none")
    if git(cwd, "rev-parse", "--is-inside-work-tree") is None:
        return 0

    base_file = state_path(session_id, cwd, "base")
    since_file = state_path(session_id, cwd, "since")

    if "--record-baseline" in sys.argv:
        head = git(cwd, "rev-parse", "HEAD")
        if head:
            write_state(base_file, head.strip())
        write_state(since_file, int(time.time()))
        return 0

    try:
        since = float(read_state(since_file))
    except ValueError:
        since = None

    baseline = read_state(base_file) or "HEAD"
    if git(cwd, "cat-file", "-e", baseline + "^{commit}") is None:
        baseline = "HEAD"
        if git(cwd, "rev-parse", "--verify", "HEAD") is None:
            baseline = None

    found = diff_additions(cwd, baseline, since) if baseline else []

    count_file = state_path(session_id, cwd, "count")
    if not found:
        write_state(count_file, 0)
        return 0

    blocks = int(read_state(count_file, "0") or 0)
    if blocks >= MAX_BLOCKS:
        print(
            f"[no-comments] {len(found)} comment(s) still flagged after "
            f"{MAX_BLOCKS} attempts; letting the turn end.",
            file=sys.stderr,
        )
        return 0
    write_state(count_file, blocks + 1)

    listed = found[:MAX_REPORTED]
    lines = [f"  {p}:{n}  {t[:100]}" for p, n, t in listed]
    if len(found) > len(listed):
        lines.append(f"  ...and {len(found) - len(listed)} more")

    reason = (
        "New code comments were added. This codebase does not take comments — "
        "the code and its names carry the meaning.\n\n"
        + "\n".join(lines)
        + "\n\nDelete every line above. Where a comment felt necessary, that is a "
        "naming or structure problem: fix the name or extract the logic instead.\n\n"
        "If you judge a comment to be genuinely critical — something a reader "
        "cannot recover from the code at all — do NOT write it. Remove it, finish "
        "the work, and tell the user in your reply what the comment would have "
        "said and where, so they can decide."
    )
    json.dump({"decision": "block", "reason": reason}, sys.stdout)
    return 0


if __name__ == "__main__":
    sys.exit(main())
