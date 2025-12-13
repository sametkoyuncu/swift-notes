# KeyPaths and Pattern Matching (with version cues)

How to leverage key paths and pattern matching to write concise, readable Swift.

## Version Quick Reference
- Swift 4+: writable key paths, `\.property` syntax.
- Swift 5.x+: `KeyPath` improvements and pattern matching ergonomics.
- Swift 5.7+: `any` spelling for existentials can appear with `KeyPath` constraints.

## KeyPath Basics
- Use `\Type.property` to reference properties without calling them. Great for mapping, sorting, and dependency injection.

```swift
struct User { let name: String; let age: Int }

let names = users.map(\.name)
let sorted = users.sorted(by: \.age) // via overload taking a key path
```

- For mutation, use `WritableKeyPath` and `ReferenceWritableKeyPath` (classes).

```swift
func set<Value>(_ keyPath: WritableKeyPath<User, Value>, to value: Value, on user: inout User) {
    user[keyPath: keyPath] = value
}
```

## Dynamic Member Lookup
- Some types expose dynamic members that forward through key paths (e.g., `SwiftUI.Binding`). You can build your own with `@dynamicMemberLookup` and subscript overloads taking key paths.

## Pattern Matching Essentials
- `switch` supports `case`, `where` clauses, and pattern bindings for enums, optionals, tuples, ranges, and custom patterns.

```swift
switch value {
case .success(let data):
    handle(data)
case .failure(let error) where error.isRetriable:
    retry()
case .failure:
    break
}
```

## `if case` / `guard case`
- Use to destructure single values without a full `switch`.

```swift
if case .failure(let error) = result { print(error) }

guard case .success(let payload) = result else { return }
process(payload)
```

## Optional Patterns
- Match `.some`/`.none` or use `if case let x?`.

```swift
if case let value? = optionalValue { print(value) }
```

## Tuple and Range Patterns
- Destructure tuples in switches; match numeric ranges with `...` or `..<`.

```swift
let point = (x: 3, y: 7)
switch point {
case (0, 0): print("origin")
case (1..., 1...): print("quadrant")
default: break
}
```

## Custom Pattern Matching
- Implement `~= (pattern:value:)` to enable custom matching. Keep it lightweight and predictable.

```swift
struct Prefix { let value: String }
func ~=(pattern: Prefix, value: String) -> Bool { value.hasPrefix(pattern.value) }

switch "swift-notes" {
case Prefix("swift"): print("matches")
default: break
}
```

## Tips
- Prefer exhaustive `switch` on enums to catch new cases at compile time.
- Combine `where` clauses for readability instead of nesting conditionals.
- Keep custom patterns simple to avoid surprising control flow.
