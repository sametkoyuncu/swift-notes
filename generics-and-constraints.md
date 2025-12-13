# Generics and Constraints (with version cues)

Practical patterns for generics, protocol constraints, and existential usage.

## Version Quick Reference
- Swift 5.6+: `any` keyword required to spell existential types explicitly.
- Swift 5.7 (Xcode 14): primary associated types, improved existential type inference, better `Sendable` checks behind flags.
- Swift 5.9 (Xcode 15): parameter packs and variadic generics (advanced; skip unless you need them).
- Swift 6+: strict concurrency checking is the default; existential/`Sendable` diagnostics are stricter.

## `where` Clauses and Conditional Conformance
- Use `where` to keep function signatures clear and constraints localized.
- Conditional conformance lets you add protocol adoption only when generic parameters meet requirements.

```swift
extension Array: Encodable where Element: Encodable {}

func merge<P: Sequence, Q: Sequence>(_ lhs: P, _ rhs: Q) -> [P.Element]
where P.Element == Q.Element {
    lhs + rhs
}
```

## Primary Associated Types (Swift 5.7)
- Protocols can surface key associated types in angle brackets, reducing boilerplate when constraining existentials.

```swift
protocol IteratorProtocol<Element> {
    associatedtype Element
    mutating func next() -> Element?
}

// Prior to 5.7: `any IteratorProtocol` lost the element type easily.
// With a primary associated type you can write:
let ints: any IteratorProtocol<Int>
```

## Existentials vs Opaque Types
- `any` creates a type-erased box; `some` preserves a single concrete type.
- Prefer `some` for return types when the function always yields one concrete conformer; use `any` when multiple conformers must flow through the same API or be stored together.

```swift
func makeNumber() -> some Numeric { 42 }     // static dispatch, concrete type hidden
let numbers: [any Numeric] = [1, 2.0, 3.0]   // heterogeneous storage
```

## Protocols with `Self` or Associated Types
- Protocols referencing `Self` or an associated type in requirements cannot be used as plain existentials without extra information.
- Reach for:
  - Generics on functions or types: `func render<P: View>(_ view: P) -> some View`
  - Type erasure wrappers: `struct AnyProvider<Item>: Provider { ... }`
  - Opaque returns when a single concrete type is guaranteed.

## Constraint Hygiene Tips
- Keep constraints close to the API that needs them; avoid lifting all constraints to top-level types.
- Prefer extension-based conformances to keep core types small and reusable.
- If a type has many conditional conformances, document the minimal required constraints to avoid surprises for callers.

## Testing
- Add focused tests around type-erased wrappers to ensure requirements are forwarded.
- For APIs relying on constraints, add compile-time checks via unused functions in test targets (e.g., a generic helper that must type-check).
