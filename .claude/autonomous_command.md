# Autonomous Task

This is an autonomous task. Keep bash commands short and limited to allowed commands in @~/.claude/settings.json. Keep commit messages to a single line: `git commit -m "My short commit message"`. Do not do multi line commit messages. Do not use command substitution such as `glab issue list --assignee @me --repo $(git remote get-url origin)`. ONLY create issues using the instructions below.

List issues by `glab issue list --assignee @me`.

DO NOT use compound commands. Create a branch simply by `git checkout -b "123-branch-name"`

