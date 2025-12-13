# Combine and AsyncSequence (with version cues)

How to bridge publishers to async/await, manage backpressure, and handle cancellation.

## Version Quick Reference
- iOS 13 / Swift 5.1: Combine introduced with `Publisher`, operators, and schedulers.
- iOS 15 / Swift 5.5: `AsyncSequence` and `Publisher.values` bridge Combine to async/await.
- Swift 6+: stricter concurrency checking surfaces `Sendable` and actor-isolation issues in custom publishers/operators.

## Bridging Combine to Async/Await
- Use `publisher.values` (iOS 15+) to consume a publisher as an `AsyncSequence`.

```swift
for await value in publisher.values {
    handle(value)
}
```

- For single values, prefer `try await publisher.first(where:)` or `async` variants instead of promise-style bridges.

## Cancellation and Backpressure
- Cancellation in Combine maps to Task cancellation in async bridges. Respect `Task.isCancelled` when producing values manually.
- Backpressure is automatic for many operators, but custom `Publisher` implementations should consider demand. When bridging to async, the consumer naturally pulls values; avoid buffering unboundedly.

## Error Handling
- Combine uses `Failure` associated type; `Never` means no errors. When bridging, failures throw in async contexts.

```swift
do {
    for try await value in fallible.values {
        handle(value)
    }
} catch {
    // handle Combine Failure here
}
```

## Common Patterns
- UI: map publishers to `async` functions in SwiftUI `task {}` blocks; cancel tasks on disappear.
- Testing: use `AsyncStream` to feed deterministic values into async code, or use TestScheduler for pure Combine pipelines.

## Replacing Combine with AsyncSequence
- For new code on iOS 15+, prefer `AsyncSequence` for simpler async streams.
- Use `AsyncStream`/`AsyncThrowingStream` to wrap callback-based APIs.

```swift
func notifications() -> AsyncStream<Notification> {
    AsyncStream { continuation in
        let token = NotificationCenter.default.addObserver(forName: .foo, object: nil, queue: nil) { note in
            continuation.yield(note)
        }
        continuation.onTermination = { _ in
            NotificationCenter.default.removeObserver(token)
        }
    }
}
```

## Concurrency Safety
- Ensure custom publishers and subjects are `Sendable` if they cross actors/threads. Consider using actors to guard mutable state in publishers you own.

## Testing
- For Combine: use `XCTest` with expectations or TestScheduler; assert output sequences and completion.
- For async bridges: write async tests with `for await` and verify cancellation by cancelling the parent `Task`.
