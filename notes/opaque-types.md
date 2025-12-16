# Opaque Types in Swift

Swift's `some` keyword lets you return a value whose concrete type stays hidden while still preserving type safety. It behaves like the inverse of `any`: callers know there is a specific type, but they only interact with the protocol requirements that type satisfies.

## Why Use Opaque Return Types?
- Hide implementation details while keeping static dispatch and optimizations.
- Avoid exposing long generic signatures from helper methods.
- Keep flexibility to swap implementations without breaking API callers.

## Basic Example

```swift
protocol Shape {
    func area() -> Double
}

struct Square: Shape {
    let edge: Double
    func area() -> Double { edge * edge }
}

struct Circle: Shape {
    let radius: Double
    func area() -> Double { Double.pi * radius * radius }
}

// Only promise that the result conforms to Shape; callers do not know if it is a Circle or Square.
func makeUnitSquare() -> some Shape {
    Square(edge: 1)
}

func makeCircle(radius: Double) -> some Shape {
    Circle(radius: radius)
}
```

Opaque types guarantee that each function returns a single concrete type. `makeUnitSquare()` always yields `Square`, while `makeCircle(radius:)` always yields `Circle` for any radius value.

## Opaque Types vs Protocol Existentials (`any`)
- `some` preserves the concrete type across the call site (the compiler still knows it), enabling inlining and overload resolution.
- `any` erases the type entirely, so value semantics like `Self` requirements or associated types become unavailable.
- For performance-critical code—such as a frequently reused builder—`some` typically avoids the dynamic dispatch overhead of `any`.

## Working with Associated Types
Protocols with associated types cannot be used directly as return types. Opaque types let you expose them safely:

```swift
protocol DataProvider {
    associatedtype Item
    func items() -> [Item]
}

struct LocalProvider: DataProvider {
    func items() -> [String] { ["alpha", "beta"] }
}

struct RemoteProvider: DataProvider {
    func items() -> [Int] { [1, 2, 3] }
}

// Callers only need to know it is a DataProvider; they do not care about Item.
func buildLocalProvider() -> some DataProvider { LocalProvider() }
```

Because `buildLocalProvider()` always returns a `LocalProvider`, the compiler can resolve `Item` as `String` internally without exposing it to callers.

## Composing Views
In SwiftUI, opaque types keep view hierarchies short and expressive:

```swift
struct MessageRow: View {
    let isOwnMessage: Bool

    var body: some View {
        HStack {
            if isOwnMessage {
                Spacer()
                bubble(color: .blue.opacity(0.2))
            } else {
                bubble(color: .gray.opacity(0.15))
                Spacer()
            }
        }
        .padding(.horizontal)
    }

    private func bubble(color: Color) -> some View {
        Text("Hello")
            .padding(12)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
```

Returning `some View` from `bubble(color:)` hides the exact view composition (text + padding + background) while enabling SwiftUI's diffing engine to optimize the layout.

## Swapping Implementations Without Breaking Callers
Opaque types let you change the concrete return type without modifying call sites, as long as the returned value still conforms to the declared protocol:

```swift
// Initially returns LocalProvider
func provider(for offlineMode: Bool) -> some DataProvider {
    offlineMode ? LocalProvider() : RemoteProvider()
}
```

The compiler rejects this implementation because the function would return two concrete types. A common fix is to wrap the types to ensure a single concrete return:

```swift
struct AnyProvider<Item>: DataProvider {
    private let _items: () -> [Item]
    init<P: DataProvider>(_ provider: P) where P.Item == Item { _items = provider.items }
    func items() -> [Item] { _items() }
}

func provider(for offlineMode: Bool) -> some DataProvider {
    let provider: AnyProvider<String> = offlineMode
        ? AnyProvider(LocalProvider())
        : AnyProvider(LocalProvider()) // Replace with RemoteProvider() after aligning Item
    return provider
}
```

The key rule: each opaque-returning function must always produce the same concrete type, even though callers only see the protocol surface.

## Testing Tips
- Use `type(of:)` inside tests to confirm the concrete type stays stable after refactors.
- Benchmark `some` versus `any` where performance matters; opaque types often remove dynamic dispatch costs.
- In SwiftUI previews, keep helper builders `private` and opaque to minimize rebuild churn when iterating on the design.

## Further Reading
- [Swift Language Reference – Opaque Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes)
- [WWDC19 – Opaque Types and the Swift type system](https://developer.apple.com/videos/play/wwdc2019/414/)
