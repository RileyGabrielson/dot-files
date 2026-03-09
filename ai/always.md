# Always: General Rules for All Languages

These rules apply universally across all programming languages and should be followed consistently.

## Verification

### Tests

Tests are how you will verify a change has been made correctly. When appropriate, write exhaustive tests that match the intended use case, and then write the logic to fulfill those tests.

### Type Checks

Whenever possible, run the type checker after making a change to ensure that there are no type errors.

## Code Clarity and Readability

### Comments

**Comments are not as good as well-named sub functions and variable names that explain intent.**

- Prefer self-documenting code over comments
- Use descriptive function and variable names that clearly express their purpose
- Comments should only be used when you need to explain **why** you are doing something, not **what** you are doing
- If code needs a comment to explain what it does, consider refactoring to make the code itself clearer
