# Property Wrappers and Result Builders (with version cues)

Practical usage of property wrappers and result builders, with version highlights.

## Version Quick Reference
- Swift 5.1: property wrappers introduced.
- Swift 5.4: result builders stabilized (formerly function builders).
- Swift 5.9+: macros arrive (not covered here); builders/wrappers remain common for DSLs.
- Swift 6+: stricter concurrency checking; wrappers interacting with concurrency may need `Sendable`/`@MainActor`.

## Property Wrappers Basics
- Wrap storage/behavior behind a projected value. Use `@propertyWrapper` on a struct/class/enum.

```swift
@propertyWrapper
struct Clamped<Value: Comparable> {
    private var value: Value
    let range: ClosedRange<Value>

    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }

    var wrappedValue: Value {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
}

struct Volume {
    @Clamped(0...100) var level = 50
}
```

- Access with `_level` to reach the storage, `$level` for the projected value (customizable via `projectedValue`).

## Common SwiftUI Wrappers (recap)
- `@State`, `@Binding`, `@ObservedObject`, `@StateObject`, `@EnvironmentObject`, `@AppStorage`, `@SceneStorage`.
- Remember: choose based on ownership/lifetime (see `swiftui-state.md`).

## Result Builders
- Builders collect expressions into a composed result (e.g., SwiftUI `ViewBuilder`).

```swift
@resultBuilder
struct StringListBuilder {
    static func buildBlock(_ components: String...) -> [String] { components }
}

@StringListBuilder
func makeStrings() -> [String] {
    "one"
    if Bool.random() { "two" }
    for i in 0..<2 { "loop \(i)" }
}
```

- Builders support `buildBlock`, `buildOptional`, `buildEither`, `buildArray`, and optionally `buildFinalResult`.
- Use `@ViewBuilder`/`@SceneBuilder` (iOS 13+) and `@ToolbarContentBuilder` (iOS 14+) in SwiftUI.

## Concurrency Considerations
- If wrapper storage crosses actors/threads, consider `Sendable` and isolation. For UI wrappers, mark with `@MainActor` when needed.
- Avoid heavy work in getters/setters of wrappers; keep them lightweight to avoid surprising costs.

## Testing
- For wrappers, test boundary cases on the wrapped/projection values.
- For builders, add small functions that must type-check to catch regressions when changing builder signatures.
