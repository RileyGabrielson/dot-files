---
name: end-day
description: Use at the end of the workday to close out assigned GitLab issues and generate maintenance issues for the current repo.
---

# End of Day Workflow

## Overview

Two-part end-of-day routine: spec maintenance issues first, then execute — so newly created issues are eligible for the execution step.

@~/.claude/autonomous_command.md

---

## Part 1 — Spec 2 Maintenance Issues

1. Check out master

2. Fetch your open assigned issues in the current repo from gitlab

3. Pick 2 maintenance findings from the current repo (see Appendix).

4. For each finding, create an issue using the Implementation Issue Template.

---

## Part 2 — Execute 2 Assigned Issues

**REQUIRED SUB-SKILL:** Use `execute-issue` for each issue.

1. Fetch your open assigned issues in the current repo (this now includes any issues just created in Part 1) from gitlab

2. Pick 2 issues. Prefer issues that are:
   - Smallest estimated scope
   - Already have clear acceptance criteria
   - Not blocked by other issues

3. For each of the 2 issues, invoke the `execute-issue` skill.

4. After all 2 are done, verify MRs are created and reference their issues.

---

## Appendix — Maintenance Issue Exploration

### Repo

The current repo (`pwd`).

### What to Look For

- **Pattern violations:** Code that doesn't follow standard conventions @~/r/ai-instructions/ai/docs/index.md
- **Bloated files:** Files over ~300 lines that could be split
- **Dead code:** Commented-out blocks, unused imports, unreferenced exports
- **Duplication:** Logic or components that exist twice and could be unified
- **Inconsistent naming:** Variables, files, or functions that break the local convention
- **Missing tests:** Non-trivial logic with no test coverage
- **Overly complex components:** Functions doing too many things

### What to ignore

- **Rendering Files**: Large svg files are not worth refactoring generally, as they are just copied from the design team.

### Exploration Steps

1. Read the repo's `CLAUDE.md` to understand its conventions
2. Run `largest-files src` to surface bloated files (>300 lines) as candidates
3. Use `Explore` subagent to scan for the patterns above
3. Select 2 findings that are small enough for a single Agent Teams session (30–90 min)
4. Create each issue in GitLab using the Implementation Issue Template

### Implementation Issue Template

```
## Context
[What and why — 2-3 sentences]

## Acceptance Criteria
- [ ] Specific, testable outcome
- [ ] All existing tests still pass
- [ ] Linter/analyzer reports no new warnings
- [ ] New tests written for new functionality

## Scope Boundaries
- DO: [exactly what to implement]
- DON'T: [what's out of scope]

## Relevant Files
- paths to relevant source and test files

## Dependencies
- Requires: #issue_number (if any)
- Blocks: #issue_number (if any)
```

### Creating Issues/MRs

@~/.claude/create_glab.md

---

## Done Checklist

- [ ] 2 maintenance issues filed for current repo (assigned to @me)
- [ ] 2 assigned issues executed (MRs open, assigned to @me)
