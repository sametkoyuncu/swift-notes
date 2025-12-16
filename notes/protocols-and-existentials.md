# Protocols, Existentials, and Composition (with version cues)

Practical patterns for using protocols, `any` vs `some`, and type erasure.

## Version Quick Reference
- Swift 5.6+: `any` keyword required for existential types.
- Swift 5.7: primary associated types improve existential ergonomics; better diagnostics for `Self` and associated-type constraints.
- Swift 6+: stricter `Sendable`/actor-isolation checks make `any` vs `some` choices more visible.

## `any` vs `some`
- `any Protocol`: type-erased box; dynamic dispatch; multiple conformers can coexist (heterogeneous containers, stored properties).
- `some Protocol`: concrete type stays hidden but fixed per function; static dispatch; great for return types when a single conformer is guaranteed.

```swift
func makeRow() -> some View { Text("Hi") } // fixed concrete type
let rows: [any View] = [Text("Hi"), Image(systemName: "star")] // heterogeneous
```

## Self Requirements and Associated Types
- Protocol requirements mentioning `Self` or an associated type block plain existential use. Reach for:
  - Generics on the function/type (`func render<P: View>(_ view: P) -> some View`)
  - Type erasure wrappers (e.g., `AnySequence`, `AnyPublisher`)
  - Opaque returns (`some`) when a single conformer is stable.

## Type Erasure Pattern
- Wrap a protocol with associated types in a box to regain existential ergonomics.

```swift
protocol DataProvider {
    associatedtype Item
    func items() -> [Item]
}

struct AnyDataProvider<Item>: DataProvider {
    private let _items: () -> [Item]
    init<P: DataProvider>(_ provider: P) where P.Item == Item { _items = provider.items }
    func items() -> [Item] { _items() }
}

let providers: [AnyDataProvider<String>] = [AnyDataProvider(LocalProvider())]
```

## Protocol Composition
- Combine requirements with `&`: `any A & B`.
- For `some`, composition still promises one concrete type that conforms to all listed protocols.

```swift
protocol Displayable { var title: String { get } }
protocol Loadable { func load() async throws }

func makeFeature() -> some Displayable & Loadable { Feature() }
```

## Extensions vs Inheritance
- Prefer protocol extensions to add shared behavior without forcing inheritance. Keep inheritance shallow; compose small protocols instead.
- Avoid over-broad “god protocols.” Split into role-focused protocols and recompose at use sites.

## Testing and Diagnostics
- When using type erasure, add small tests to ensure forwarding works (`items()` returns expected values).
- If you need compile-time coverage, add helper functions in tests that must type-check to catch regressions in constraints.
