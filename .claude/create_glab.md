# Creating Issues/MRs in Gitlab

Use the `create-issue` bin command to create each issue. Use the Write tool to write the description to a file in the repo root (first line = title, rest = body), pass it to `create-issue`, then delete it with the Bash tool. ONLY create issues this way.

```
# 1. Use the Write tool to write to the repo root, e.g. .issue-temp.md
#    First line = issue title, remaining lines = body

# 2. Run the command (milestone is optional)
create-issue .issue-temp.md
create-issue .issue-temp.md "My Milestone Name"

# 3. Delete the temp file
rm .issue-temp.md
```

Use the exact same pattern to create an MR using `create-mr`. 

