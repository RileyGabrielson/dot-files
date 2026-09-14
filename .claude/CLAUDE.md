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

## Code Conventions

- **Default to no comment.** Write one only when the meaning genuinely can't be read off the code and the names — non-obvious *why*, never restated *what*. A comment narrating what the next line does is noise: delete it, or fix the name that made it necessary. Applies to inline comments as much as doc comments, and to code review as much as to writing new code. When in doubt, leave it out.

- Comments never reference GitLab issue/MR/epic numbers — external IDs mean nothing in source and rot. Future work gets a plain `TODO:` describing what needs to happen, not which ticket tracks it.

- Doc comments stay terse. Private functions get none unless genuinely non-obvious; exported ones match their package siblings (1-3 lines). Don't restate what the code already says.
