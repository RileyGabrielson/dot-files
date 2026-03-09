# TypeScript Rules and Guidelines

TypeScript-specific rules and best practices.

## Type Safety

### No Type Casting

**Do not use type casting (type assertions) unless absolutely necessary.**

Type casting bypasses TypeScript's type checking and can lead to runtime errors. Instead:

- Fix the underlying type issues
- Use proper type guards
- Improve type definitions
- Use type narrowing instead of assertions

**When type casting might be acceptable:**
- When interfacing with untyped third-party libraries (but prefer creating proper type definitions)
- When dealing with complex type transformations that TypeScript cannot infer (but document why)
