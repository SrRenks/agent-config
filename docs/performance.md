# Performance Guidelines

## Goals

Performance requirements must be defined per project.

Document:
- latency targets
- throughput requirements
- resource constraints
- scalability expectations

## Profiling
- Use tools like `pprof`, `perf`, `flamegraphs`.
- Profile in production-like environments.
- Analyze CPU, memory, I/O, and network.

## Optimization Practices
- Use batching over single operations.
- Use connection pooling for databases.
- Cache frequently accessed data (in‑memory or Redis).
- Use async/await or goroutines for I/O-bound tasks.
- Optimize database queries with indexes.
- Never trade maintainability for hypothetical performance gains.
- Performance optimizations must be supported by profiling or benchmarks.


## Bottlenecks
- Identify and eliminate slow paths.
- Use tracing (e.g., OpenTelemetry) to find bottlenecks.

## Monitoring
- Track response times, error rates, and resource usage.
- Set up alerts for anomalies.

## Optimization Rule

Do not optimize based on assumptions.

Required:
- benchmark
- profiler data
- production metrics

before introducing performance-specific complexity.