---
name: create-issue
description: Create a GitLab issue in the current repo using the create-issue command. Use when the user asks to create a single issue, log a bug, or add a task to GitLab.
argument-hint: [issue title or description]
---

Create a GitLab issue for the current repo.

## Steps

1. Counsel with the user about the boundaries of the issue. Clarify parts that are not clear, architectural boundaries that are not well defined, etc.
2. Draft the issue content using the implementation issue template from the global standards (context, acceptance criteria, scope boundaries, relevant files, dependencies).
3. Use the Write tool to write the issue to `.issue-temp.md` in the repo root. The first line is the issue title; remaining lines are the body.
4. Run `create-issue .issue-temp.md` (optionally pass a milestone name as the second argument if one was specified).
5. Delete the temp file with the Bash tool.

@~/.claude/create_glab.md
