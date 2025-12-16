# SwiftUI State Management (with version cues)

How to choose between `@State`, `@Binding`, `@ObservedObject`, `@StateObject`, and `@EnvironmentObject`, plus navigation/state patterns.

## Version Quick Reference
- iOS 13 / SwiftUI 1.0: `@State`, `@Binding`, `@ObservedObject`, `@EnvironmentObject`.
- iOS 14+: `@StateObject`, `@AppStorage`, `@SceneStorage`, `LazyVGrid/HStack`, improved `NavigationLink`.
- iOS 16+: `NavigationStack` / `NavigationPath`, `NavigationSplitView`; grid/list improvements.
- iOS 17+: observation macro (`@Observable`) and `@Bindable` (if available in your toolchain); stick to classic patterns if you target earlier OSes.

## Core Property Wrappers
- `@State`: local, view-owned value. Resets when view is re-created; keep it lightweight and value-semantic.
- `@Binding`: derived write-through reference to a `@State`. Use for child views that mutate parent state.
- `@ObservedObject`: external reference type owned elsewhere. Use when lifetime is managed by a parent.
- `@StateObject`: reference type owned by the view; initialized once per view identity. Use for view-owned models.
- `@EnvironmentObject`: shared object injected via environment. Keep the surface small; avoid making it a grab-bag.

## Choosing the Right Wrapper
- Start with `@State` for simple local fields.
- Promote to `@StateObject` when you need an observable reference that must persist across view reloads (e.g., network-backed view model).
- Use `@ObservedObject` when the parent owns the model and passes it down.
- Use `@Binding` for two-way value flows between parent/child (e.g., toggles, text fields).
- Reserve `@EnvironmentObject` for app-wide or feature-wide shared state; provide it high in the tree.

## Navigation Patterns (iOS 16+)
- Prefer `NavigationStack` with `NavigationPath` for programmatic navigation and deep links.

```swift
struct Detail: Hashable { let id: UUID }

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List(0..<5) { idx in
                NavigationLink(value: Detail(id: UUID())) { Text("Item \(idx)") }
            }
            .navigationDestination(for: Detail.self) { detail in
                Text("Detail \(detail.id.uuidString)")
            }
        }
    }
}
```

## Side Effects and Async Work
- Run lightweight effects in `task {}` for one-off work when the view appears; use `.onChange(of:)` for reacting to state changes.
- Cancel ongoing tasks when state changes if the work is obsolete (store `Task` handles in `@State` or `@StateObject`).
- Keep async logic in view models when it grows; surface results via published properties.

## Performance Tips
- Minimize state surface: store only what the view needs to render; derive computed values when possible.
- Break views into smaller components to reduce diffing scope; pass bindings to avoid redundant observable objects.
- Avoid storing large reference types in `@State`; prefer `@StateObject` for long-lived references.

## Testing and Previews
- For previews, inject lightweight mock view models and deterministic data.
- For snapshot/UI tests, use stable seeds for randomized content and navigation paths.
