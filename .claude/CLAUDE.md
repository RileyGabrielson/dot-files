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
