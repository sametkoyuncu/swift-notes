# Dispatch (Swift)

## 1. What is it?
Dispatch is the mechanism that decides **which implementation** a call will execute (and **when** that decision is made: compile-time vs runtime). In Swift, dispatch choices directly affect polymorphism, correctness (especially with protocol extensions), and performance.

## 2. What problem does it solve?
- Enables polymorphism (same call, different behavior) via inheritance or protocols.
- Balances flexibility vs performance (dynamic lookup vs direct calls).
- Defines how overrides, protocol conformances, and runtime features (KVO/swizzling) work.

## 3. Types / Categories
| Kind | Trigger / Where it appears | Mechanism | Typical cost | Notes |
|---|---|---|---|---|
| Static dispatch (direct call) | `struct`/`enum`, `final` methods/classes, `static` functions, many generics | Compiler emits a direct call | Lowest | Most optimizable (inline, specialize) |
| Virtual dispatch (vtable) | `class` inheritance + overridable methods | vtable lookup | Low–medium | Enables `override` polymorphism |
| Protocol dispatch (witness table) | Calling protocol **requirements** through a protocol type | witness table lookup | Low–medium | Key for `any Protocol` calls |
| Obj-C message dispatch | `@objc dynamic`, KVC/KVO, swizzling, selectors | `objc_msgSend` | Medium–high | Most dynamic, least optimizable |

## 4. How does it work in Swift?
### Quick decision tree
- **Value types (`struct`/`enum`)** → usually **static dispatch**
- **`final class` or `final func`** → **static dispatch** (cannot be overridden)
- **Non-final `class` methods** (especially overridden) → **vtable** dispatch
- **Protocol requirement calls via `any Protocol`** → **witness table** dispatch
- **Protocol extension methods** → **static dispatch** (common footgun)
- **Generic `T: Protocol`** → often **specialized** by the compiler → can become close to **static dispatch**
- **`@objc dynamic`** → **Objective-C runtime** dispatch (`objc_msgSend`)

### Why protocol extensions can surprise you
- A method implemented in a **protocol extension** is not always dispatched through the witness table.
- If you call it via an **existential** (`let x: any P = ...`), Swift may bind to the extension implementation (static) instead of the conforming type’s method (dynamic through witness table).

Rule of thumb:
- If you want dynamic behavior through `any P`, make it a **protocol requirement** and implement it in the conforming type.
- Treat protocol extensions as **shared helpers**, not as “overridable defaults”.

### `some` vs `any` (performance intuition)
- `any P` (existential): runtime container + witness table lookup.
- `some P` (opaque): compiler knows the concrete type (per function boundary) → more optimization opportunities (specialization / inlining), often closer to static dispatch.

## 5. Dangerous corners / Footguns
- ⚠️ **Protocol extension “override” illusion**: methods in extensions are not truly overridable the way class methods are.
- ⚠️ **Existentials hide concrete types**: `any P` can introduce runtime costs and can change which implementation gets called.
- ⚠️ Overusing non-final classes can prevent optimizations (no devirtualization / inlining).
- ⚠️ `@objc dynamic` makes behavior swizzlable but reduces compile-time guarantees and performance.

## 6. When should I use which?
- Prefer **static dispatch** by default:
  - Use `struct`/`enum` for pure data + value semantics.
  - Mark classes/methods `final` unless you truly need inheritance.
- Use **vtable dispatch** when:
  - You need runtime polymorphism via inheritance (`override`-based design).
- Use **protocol dispatch** when:
  - You need abstraction and testability (DI), especially across module boundaries.
  - Prefer generics/`some P` when you want abstraction + performance.
  - Use `any P` when you need heterogenous collections, dynamic storage, or API surface that must hide types.
- Use **Obj-C dispatch** when:
  - Interop with Objective-C runtime is required (KVO, swizzling, selectors, some UIKit patterns).

## 7. 30-second summary
- **If the compiler knows the exact target** → direct (static) call.
- **Classes with overrides** → vtable.
- **Protocol requirements via `any Protocol`** → witness table.
- **Protocol extension methods** → often static (watch out).
- **`some Protocol`** helps performance because the compiler can specialize/in-line.
- **`@objc dynamic`** uses Obj-C runtime dispatch: most flexible, least optimizable.
