# Collections and Algorithms (with version cues)

Sequence vs Collection, common transforms, and performance considerations.

## Version Quick Reference
- Swift 5.x+: standard library offers CoW collections, lazy views, and SIMD-backed `ContiguousArray`.
- Swift 5.7+: improved type inference with primary associated types; `any` spelling required for existentials.
- Swift 5.9+: parameter packs/variadic generics (advanced; not covered here).

## Sequence vs Collection
- `Sequence`: single-pass iteration guaranteed; may be destructive. Use when you don’t need indices or multiple passes.
- `Collection`: multi-pass with stable indices (`startIndex`/`endIndex`). Prefer for in-memory data you traverse multiple times.

## Common Transforms
- `map/compactMap/flatMap`: convert, filter nils, flatten.
- `filter`: keep matching elements; be mindful of allocation on large data.
- `reduce`: combine into a single value; prefer `reduce(into:)` to avoid intermediate allocations.

```swift
let upper = names.map { $0.uppercased() }
let numbers = strings.compactMap(Int.init)
let flattened = [[1,2],[3]].flatMap { $0 }
let counts = words.reduce(into: [:]) { $0[$1, default: 0] += 1 }
```

## Lazy Views
- Use `.lazy` to defer work and reduce intermediate allocations, especially after filters and maps chained together.

```swift
let firstBig = numbers.lazy.filter { $0 > 1000 }.first
```

## Slicing and Subsequence
- Slices (`ArraySlice`, `Substring`) share storage with the base collection; copy to `Array`/`String` if you need long-term storage.

```swift
let slice = array[2...]      // ArraySlice
let copy = Array(slice)      // makes an owned copy
```

## Sorting and Searching
- `sorted()` returns a new array; `sort()` mutates in-place (more memory efficient).
- For membership checks on large datasets, consider `Set` or `Dictionary` over linear `contains`.

## Mutations and Performance
- Prefer `reserveCapacity` on arrays and dictionaries when size is known to reduce reallocations.
- For hot paths, avoid repeated `removeFirst()` on arrays (O(n)); use indices or `popLast()` where order permits.

## Algorithms to Remember
- `zip` to iterate pairs; `stride(from:to:by:)` for steps; `prefix/while`, `drop/while` for stream-like processing.
- `grouping` via `Dictionary(grouping:by:)`; `chunks` manually via stride or rolling indices.

## Testing
- Add property-based checks (if available) for algorithms to ensure invariants (e.g., sorted output length matches input).
- Benchmark critical paths with `measure` in XCTest or simple timing helpers; ensure lazy vs eager choices are intentional.
