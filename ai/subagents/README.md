# Subagents

This directory contains descriptions of specialized AI subagents that work together to handle complex development tasks.

## Agent Types

### [Planner Agent](./planner.md)
Responsible for breaking down complex tasks into actionable steps and creating structured implementation plans.

### [Implementer Agent](./implementer.md)
Responsible for executing plans and writing the actual code implementation.

### [Verifier Agent](./verifier.md)
Responsible for validating implementations, running tests, and ensuring code quality.

## Workflow

These agents typically work in sequence:

1. **Planner** → Analyzes requirements and creates a detailed plan
2. **Implementer** → Executes the plan and writes the code
3. **Verifier** → Validates the implementation and ensures quality

However, agents may iterate or work in parallel when appropriate.

## Usage

When working on complex tasks, these agents can be invoked to:
- Break down large features into manageable steps
- Ensure systematic implementation
- Maintain code quality through verification
- Provide clear separation of concerns in the development process
