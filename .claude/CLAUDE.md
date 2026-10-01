# Global AI Agent Instructions

## RTK

@RTK.md

## Shell Aliases

Use the `largest-files` alias instead of raw `wc -l` pipelines when finding the largest files in a project. Example: `largest-files` (run from the project root, or `cd` first).

## Autonomous

@autonomous_command.md

## Testing

Never use `vi.stubGlobal` or any other global mock pattern. Instead, inject dependencies (like `document`, `window`, etc.) through the constructor or port interface, and pass fakes directly in tests. If you're tempted to mock a global, add it as a dependency instead.

Each test must be fully isolated — mocks must not persist longer than a single test. Create mocks fresh inside each test or via per-test factory functions. Avoid `beforeEach` setups that share mock state across tests unless there is a genuine reason for it.

Never assert on `console.warn` or `console.error` calls. If a guard condition matters, test its observable effect instead (e.g. nothing added to a signal, no function called).

## Gitlab Operations

@create_glab.md

## Tone

- **Be Concise.** Be direct, clear, and concise. Do not overexplain. Professional and terse.

## Code Conventions

- **Write no comments.** Not a default to weigh — a rule. The code and its names carry the meaning. A comment narrating what the next line does is noise; a comment you reach for is a naming or structure problem, so fix the name or extract the logic instead. Applies to inline comments as much as doc comments, and to code review as much as to writing new code.

- **If a comment is genuinely critical, tell the user — don't write it.** When something truly cannot be recovered from the code (a non-obvious *why*, a hard-won constraint, a landmine), leave it out of the source, finish the work, and say in your reply what the comment would have said and where it would go. The user decides whether it earns a place in the file. This is the only route to a comment in the codebase.

- Compiler and linter pragmas (`//go:build`, `// @ts-ignore`, `# type: ignore`, `# noqa`, shebangs, and the like) are not comments for this purpose. Write them as needed.

- A `Stop` hook (`.claude/hooks/no-comments.py`) enforces this mechanically: it diffs the working tree against the commit the session started from and blocks the turn from ending while any newly added comment remains.

- No `TODO:` comments. Future work goes to the user or to a GitLab issue, never into the source. If the user does approve a comment, it never references GitLab issue/MR/epic numbers — external IDs mean nothing in source and rot.

- No doc comments, on exported symbols or anything else. A name that needs a doc comment is the wrong name.
