# Memory and Value Semantics (with version cues)

ARC basics, retain cycles, copy-on-write, and value vs reference semantics.

## Version Quick Reference
- Swift 5.x+: ARC for reference types; standard library uses copy-on-write (CoW) for `Array`, `Dictionary`, `Set`.
- Swift 5.7+: stricter `Sendable` checking (behind flags) helps surface thread-safety and aliasing issues.
- Swift 6+: strict concurrency checking by default; `@MainActor`/`Sendable` diagnostics catch unsafe sharing early.

## ARC Essentials
- Classes and closures are reference types managed by ARC. Increments on strong references; decrements on release.
- Avoid retain cycles by breaking strong references in one direction (`weak` or `unowned` depending on lifetime guarantees).

```swift
final class Controller {
    var handler: (() -> Void)?
    func start() {
        handler = { [weak self] in self?.doWork() }
    }
}
```

## `weak` vs `unowned`
- `weak`: optional, set to `nil` automatically when the instance deallocates. Use when the reference may outlive the owner.
- `unowned`: non-optional, crashes if accessed after deallocation. Use only when lifetimes are strictly tied.

## Copy-on-Write (CoW)
- Standard collections are value types with CoW: copying is cheap until mutation.

```swift
var a = [1, 2, 3]
var b = a            // shares storage
b.append(4)          // triggers copy; `a` remains [1, 2, 3]
```

- When building your own CoW types, store reference-backed storage and implement `mutating` setters that call `isKnownUniquelyReferenced`.

```swift
struct Buffer {
    final class Storage {
        var values: [Int]
        init(_ values: [Int]) { self.values = values }
    }
    private var storage = Storage([])

    private mutating func ensureUnique() {
        if !isKnownUniquelyReferenced(&storage) {
            storage = Storage(storage.values)
        }
    }

    mutating func append(_ value: Int) {
        ensureUnique()
        storage.values.append(value)
    }
}
```

## Value vs Reference Semantics
- Prefer value types (struct/enum) for domain models; they compose better and avoid aliasing bugs.
- Use classes for shared mutable state, UI objects, or when identity matters.
- Document ownership: who creates, who retains, and who mutates.

## Concurrency Considerations
- CoW reduces accidental sharing across threads, but mutable references inside structs can still race. Mark shared references as `Sendable` or wrap in actors/locks.
- `@MainActor` on UI-bound classes clarifies threading; for data models, prefer pure value types or isolated actors.

## Testing
- Add tests to ensure CoW types copy on mutation (check identity before/after mutation).
- For retain cycles, use weak expectations in tests: create, nil-out strong refs, and assert deallocation occurs.
