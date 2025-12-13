# Error Handling in Swift (with version cues)

Practical patterns for throwing, typed throws, and interop.

## Version Quick Reference
- Swift 5.x: untyped `throws`, `rethrows`, `Result`, `try?`, `try!`.
- Swift 6+: typed throws (`throws(SomeError)`) available by default; strict concurrency checking may surface error-sendability issues.

## Basics
- Use `throws` for recoverable issues; keep errors small and domain-specific.
- Prefer enums conforming to `Error`; include minimal context (payloads or `userInfo` when bridging).

```swift
enum NetworkError: Error { case offline, timeout(seconds: Int) }

func fetch() throws -> Data {
    guard isOnline else { throw NetworkError.offline }
    return Data()
}
```

## Typed Throws (Swift 6+)
- Specify the exact error type to enable exhaustive handling at call sites.

```swift
enum LoginError: Error { case offline, invalidCredentials }

func login(email: String, password: String) throws(LoginError) -> Session { ... }

do {
    _ = try login(email: "a@b.com", password: "pw")
} catch LoginError.offline {
    // precise recovery
} catch {
    // optional fallback if bridging from ObjC or unexpected errors arise
}
```

## Rethrows
- Use `rethrows` when a function only throws if its function parameter throws—helpful for higher-order functions.

```swift
func mapOrThrow<T>(_ values: [String], transform: (String) throws -> T) rethrows -> [T] {
    try values.map(transform)
}
```

## `Result` vs `throws`
- `throws` is ergonomic inside async/await and linear code.
- `Result` is useful for storing or combining errors, or when API shape must be synchronous but errorful.

```swift
let outcome: Result<Data, NetworkError> = Result { try fetch() }
```

## Async Error Propagation
- `async throws` pairs naturally; prefer this over callback-based completion handlers.
- For cancellation, treat `CancellationError` distinctly to avoid masking user intent.

```swift
func loadProfile() async throws -> Profile { ... }

do {
    _ = try await loadProfile()
} catch is CancellationError {
    // respect user cancellation
}
```

## Bridging and Interop
- Objective-C `NSError` maps to Swift `Error`; annotate ObjC with `NS_SWIFT_NAME` and `NSError **` patterns.
- When exposing Swift APIs to ObjC, typed throws are not visible; design ObjC-friendly overloads if needed.

## Testing Errors
- Use `XCTAssertThrowsError` with pattern matching to assert specific cases.
- For typed throws, tests become clearer and more exhaustive.

```swift
XCTAssertThrowsError(try login(email: "", password: "")) { error in
    XCTAssertEqual(error as? LoginError, .invalidCredentials)
}
```
