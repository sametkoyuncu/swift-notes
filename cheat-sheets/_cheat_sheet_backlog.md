Core Language & Runtime
	•	Dispatch in Swift (Static, vtable, witness, ObjC)
	•	Value vs Reference Semantics
	•	ARC and Memory Management
	•	Copy-on-Write (CoW) Mechanics
	•	final and Devirtualization
	•	Swift ABI & Stability (What actually matters)

⸻

Protocols, Generics, Abstraction
	•	Protocol vs Generic
	•	some vs any (Opaque vs Existential)
	•	Existential Containers
	•	Protocol Extensions: Power & Footguns
	•	Associated Types vs Generics
	•	Type Erasure (e.g. AnyView, AnyPublisher)

⸻

Performance-Oriented Thinking
	•	Static vs Dynamic Dispatch Trade-offs
	•	Inlining and Specialization
	•	Heap vs Stack Allocation
	•	Measuring Performance in Swift (Mental Model)
	•	When Abstractions Become Expensive

⸻

Concurrency & Parallelism
	•	Swift Concurrency Mental Model
	•	Task vs Thread vs GCD
	•	Task Priority & Inheritance
	•	Structured vs Unstructured Concurrency
	•	Actors and Isolation
	•	Sendable and Data Race Safety
	•	@MainActor and Thread Hops

⸻

Interoperability & Runtime Escapes
	•	Swift ↔ Objective-C Interop
	•	@objc and dynamic
	•	KVO & Method Swizzling (Why and Costs)
	•	Bridging Value Types to ObjC

⸻

SwiftUI-Specific (Runtime-Focused)
	•	some View and View Composition
	•	SwiftUI View Identity & Lifetime
	•	State Management Cost Model
	•	SwiftUI Performance Footguns
	•	PreferenceKey & Environment Internals

⸻

Architecture & Design Decisions
	•	Composition over Inheritance (Swift Perspective)
	•	Protocol-Oriented Programming (What It Actually Means)
	•	Dependency Injection in Swift (Protocols vs Closures)
	•	API Design Guidelines (Why They Exist)
	•	Public API Boundaries & Performance
