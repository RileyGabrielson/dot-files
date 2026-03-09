# AI Instructions and Rules

This directory contains a compilation of instructions and rules for AI agents to follow when working on code. The files are organized by topic and language specificity.

## File Structure

- **`_intro.md`** (this file): Explains how to use the files in this directory
- **`always.md`**: General rules that apply to all programming languages
- **`typescript.md`**: TypeScript-specific rules and guidelines
- **`react.md`**: React-specific rules and guidelines
- **`subagents/`**: Descriptions of specialized subagents (Planner, Implementer, Verifier) used by the `orchestrate` model
- Additional language-specific files may be added as needed

## How to Use These Files

When working on code, AI agents should:

1. **Read `_intro.md` first** to understand the structure and purpose of this directory
2. **Always consult `always.md`** for general coding principles that apply universally
3. **Check language-specific files** (e.g., `typescript.md`) only when working with that language or framework
4. **Apply rules consistently** across all code changes
5. **Suggest New Rules** when an instruction seems generally applicable

## Complex Tasks and the Orchestrate Model

For complex tasks that require multiple steps, careful planning, and verification, agents can use the **`orchestrate`** subagent model. This model coordinates three specialized subagents:

- **Planner**: Breaks down complex tasks into actionable steps
- **Implementer**: Executes plans and writes code
- **Verifier**: Validates implementations and ensures quality

### When to Use Orchestrate

Agents should suggest using the `orchestrate` model (or users can request it) when:
- Tasks involve multiple files or components
- Implementation requires careful planning and verification
- The task has multiple dependencies or steps
- Quality assurance and testing are critical
- The task would benefit from systematic decomposition

See the [`subagents/`](./subagents/) directory for detailed descriptions of each subagent.

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
