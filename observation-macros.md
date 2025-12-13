# Observation Macros (`@Observable` / `@Bindable`) (iOS 17+)

Lightweight SwiftUI observation introduced in iOS 17 / macOS 14. Replaces many `ObservableObject` boilerplates; still opt-in depending on deployment target.

## Version Quick Reference
- iOS 17, macOS 14, watchOS 10, tvOS 17: `@Observable` and `@Bindable`.
- Older OS targets: stick with `ObservableObject`, `@Published`, `@StateObject`/`@ObservedObject`.

## Basic Usage
- Mark a reference type (or actor) with `@Observable` to synthesize change notifications for stored properties.

```swift
@Observable
final class CounterModel {
    var count = 0
    func increment() { count += 1 }
}

struct CounterView: View {
    @State private var model = CounterModel()
    var body: some View {
        VStack {
            Text("\(model.count)")
            Button("Plus") { model.increment() }
        }
    }
}
```

- No need for `ObservableObject` or `@Published`; mutation on observed properties triggers view updates.

## `@Bindable`
- Use `@Bindable` in child views to get bindings into an `@Observable` model without manually creating `Binding` values.

```swift
struct DetailView: View {
    @Bindable var model: CounterModel
    var body: some View {
        Stepper("Count", value: $model.count)
    }
}
```

## Interop with Existing Patterns
- You can mix `@Observable` models with `@StateObject` when you own the lifetime, or pass them down with `@ObservedObject`-like semantics using plain references (the model itself performs observation).
- For legacy targets, keep an `ObservableObject` wrapper or use conditional compilation:

```swift
#if canImport(Observation)
@Observable final class ProfileModel { var name = "" }
#else
final class ProfileModel: ObservableObject { @Published var name = "" }
#endif
```

## Concurrency Notes
- Observation macros work with actors too; the generated conformance handles main-actor isolation if your type is `@MainActor`.
- Avoid heavy work in property observers; keep state updates lightweight and move side effects to methods.

## Testing
- In previews/tests, mutate properties and assert UI/output changes. For legacy fallback, ensure both code paths stay in sync using small compile-time helpers or conditional tests.
