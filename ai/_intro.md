# AI Instructions and Rules

This directory contains a compilation of instructions and rules for AI agents to follow when working on code. The files are organized by topic and language specificity.

## Subagent Workflow (MANDATORY)

**ALL coding tasks MUST use the subagent workflow. DO NOT SKIP THIS STEP. DO NOT IMPLEMENT DIRECTLY YOURSELF.**

This workflow is mandatory, not optional, and applies to ALL tasks regardless of complexity (simple tasks, complex tasks, bug fixes, refactoring).

### The Three-Step Process

When you receive a coding task, you MUST follow these steps in order using the `mcp_task` tool:

1. **Planner**: Use the planner subagent to break down the task into actionable steps. DO NOT create plans yourself.
2. **Implementer**: Use the implementer subagent to execute the plan and write code. DO NOT write code directly yourself.
3. **Verifier**: Use the verifier subagent to validate the implementation and ensure quality. DO NOT verify yourself.

### Rules

**You MUST:**
- ✅ Use `mcp_task` to launch the planner subagent first
- ✅ Use `mcp_task` to launch the implementer subagent with the plan
- ✅ Use `mcp_task` to launch the verifier subagent to check the work
- ✅ Delegate ALL coding work to subagents
- ✅ Point subagents to this directory for best practices and rules

**You MUST NOT:**
- ❌ Create plans yourself and then implement
- ❌ Implement code directly without using subagents
- ❌ Skip verification
- ❌ Do any part of the coding task yourself

See the [`subagents/`](./subagents/) directory for detailed descriptions of each subagent.

## File Structure

- **`_intro.md`** (this file): Explains how to use the files in this directory
- **`always.md`**: General rules that apply to all programming languages
- **`typescript.md`**: TypeScript-specific rules and guidelines
- **`react.md`**: React-specific rules and guidelines
- **`subagents/`**: Descriptions of specialized subagents (Planner, Implementer, Verifier)
- Additional language-specific files may be added as needed

## How to Use These Files

When working on code, AI agents should:

1. **Read `_intro.md` first** to understand the structure and purpose of this directory
2. **Always consult `always.md`** for general coding principles that apply universally
3. **Check language-specific files** (e.g., `typescript.md`) only when working with that language or framework
4. **Apply rules consistently** across all code changes
5. **Suggest New Rules** when an instruction seems generally applicable

## Adding New Rules and Memories

Agents can add new rules and memories to these files in the following ways:

### Adding Rules

1. Ask for confirmation before adding a rule
2. **For general rules**: Add to `always.md` if the rule applies to all languages
3. **For language-specific rules**: Add to the appropriate language file (e.g., `typescript.md`)
4. **For new languages**: Create a new file following the naming pattern `<language>.md`

## Best Practices

- Review existing rules before adding new ones to avoid duplication
- Update rules when patterns change or better practices emerge
- Keep rules focused and avoid overly prescriptive guidelines
- Document the reasoning for important rules
