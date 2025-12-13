# Swift Concurrency Notes (with version cues)

This note focuses on practical Swift concurrency patterns and calls out the Swift versions where features became available or tightened.

## Version Quick Reference
- Swift 5.5 (Xcode 13 / iOS 15): `async/await`, `Task`, `TaskGroup`, actors, `MainActor`, `AsyncSequence`.
- Swift 5.7 (Xcode 14): stricter `Sendable` checking opt-in via `-strict-concurrency` (warnings); better actor-isolation diagnostics.
- Swift 6+ (Xcode 16): strict concurrency checking on by default in new projects; typed throws available without feature flags; prefer these defaults for new codebases.

> If you build with an older toolchain, gate newer features with `#if compiler(>=6.0)` or keep a note in the file header.

## Structured vs Unstructured Tasks
- Prefer structured concurrency: `async let` and `withTaskGroup` tie child lifetimes to the parent scope.
- Use unstructured `Task { ... }` sparingly for fire-and-forget work; always inject cancellation checks to avoid leaks.

```swift
func loadProfile() async throws -> Profile {
    async let user = api.user()
    async let posts = api.posts()
    return Profile(user: try await user, posts: try await posts)
}
```

## Cancellation
- Task cancellation is cooperative. Check `Task.isCancelled` or call `try Task.checkCancellation()` inside loops or longer operations.
- Propagate cancellation early from child tasks to avoid wasted work.

```swift
for try await item in stream {
    try Task.checkCancellation()
    process(item)
}
```

## Actors and Isolation
- Actors serialize access to their mutable state. Mark UI-facing APIs with `@MainActor`.
- Use `nonisolated` for read-only members, and `nonisolated(unsafe)` only when you can prove thread-safety manually (avoid unless necessary).

```swift
actor Counter {
    private var value = 0
    func increment() { value += 1 }
    func current() -> Int { value }
}
```

## Sendable and Data Races
- Mark value types that cross concurrency domains as `Sendable`. Swift 6 treats many violations as errors.
- Use `@unchecked Sendable` only when you have your own synchronization; prefer immutable structs/enums to avoid it entirely.

## Typed Throws (Swift 6+)
- Swift 6 toolchains let you declare the concrete error type a function can throw. Callers can switch exhaustively on error cases and avoid `as?`.

```swift
enum LoginError: Error { case offline, invalidCredentials }

func login(email: String, password: String) throws(LoginError) -> Session {
    guard isOnline else { throw .offline }
    guard isValid(email, password) else { throw .invalidCredentials }
    return Session(token: "abc")
}

do {
    let session = try login(email: "a@b.com", password: "pw")
    print(session)
} catch LoginError.offline {
    // can recover based on the precise type
} catch {
    // fallback for unexpected errors (e.g., when bridging from ObjC)
}
```

## AsyncSequence / Combine Bridge
- `AsyncSequence` fits most streaming needs; prefer it over manual callbacks.
- To bridge Combine publishers to `AsyncSequence`, use `values` on `AnyPublisher` (iOS 15+).

```swift
for await value in publisher.values {
    handle(value)
}
```

## Testing Concurrency
- Use `XCTestExpectation` less; prefer async tests: `func testFoo() async throws`.
- For isolation, inject dependencies with protocols and provide synchronous fakes in tests.
- Add targeted tests to ensure typed throws surfaces remain stable after refactors (`XCTAssertThrowsError` with pattern matching on the typed error).
