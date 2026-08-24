# System architecture

## High-level overview
[Describe your system's main components and their interactions.]

## Layers / modules
- Presentation Layer: Handles user input (CLI, API, UI).
- Business Logic: Core domain logic, use cases, services.
- Data Access: Repositories, database clients, external API clients.

## Data flow
[Explain how data moves through the system from request to response.]

## Key components
- Component A: Responsible for [X].
- Component B: Responsible for [Y].

## Technology stack
- Language: [e.g., Go 1.24]
- Framework: [e.g., Gin, Echo, none]
- Database: [e.g., PostgreSQL 17]
- Message Queue: [e.g., RabbitMQ, Kafka]

## External dependencies
- [List critical third-party services or libraries.]

## Ownership boundaries

Define:
- which module owns each responsibility
- allowed dependencies between modules
- forbidden dependency directions

Do not create circular dependencies.

## Architectural constraints

To preserve modularity and prevent architecture erosion, the following dependency directions are enforced:

- Presentation layer (CLI/API/UI) may depend on Application and Domain, but not on Infrastructure directly.
- Application layer may depend on Domain and Infrastructure (via interfaces), but not on Presentation.
- Domain layer must not depend on Infrastructure or Presentation - it is the core, independent of frameworks.
- Infrastructure layer may depend on Domain and Application (to implement interfaces), but not on Presentation.

Forbidden examples:
- Controllers directly accessing database connections or external services.
- UI code importing ORM or network clients.
- Domain entities using framework annotations that tie them to a specific infrastructure.

Allowed:  
- Infrastructure providing implementations of domain interfaces (dependency inversion).
- Application orchestrating use cases, calling domain services, and using infrastructure adapters.

Enforce these dependency directions.

Adapt them to the existing repository architecture.
Do not introduce these layers if the project does not already follow this model.

## Architectural consistency

Extend existing architectural patterns. Do not introduce a new architectural
style, dependency direction, or abstraction pattern for an already solved
problem unless an ADR documents the technical justification.

## Evolution history
- [Keep a log of major architectural decisions; see `docs/decisions/` for ADRs.]