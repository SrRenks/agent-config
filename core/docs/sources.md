# Sources and evidence (v2026-09-15)

Purpose: where each behavior rule, design choice, and numeric threshold in this config comes from.
How to read it: entries are grouped by domain. Each one names the source, the URL or DOI, the retrieval date, and the config files it justifies.
Policy: a new behavioral rule or numeric threshold ships with its entry here, in the same commit (core/docs/agent-config-authoring.md, wiring checklist). A claim with no citable source is labeled repo design or community practice, never left silent.

## Prose and AI writing
- Wikipedia, Signs of AI writing (WikiProject AI Cleanup): https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing (retrieved 2026-09-15). Used in: core/docs/ai-writing.md, the vocabulary, sentence-pattern, formatting, and structure lists.
- Google, developer documentation style guide: https://developers.google.com/style (retrieved 2026-09-15). Used in: plain register and second person in core/docs/ai-writing.md, human-facing sections of core/docs/project-docs.md.

## Agent behavior, context, and instructions
- Andrej Karpathy, llm-rigor principles (think before coding, surgical changes, minimum viable code, pushback scales with certainty): https://github.com/luiscrsilveira/llm-rigor (retrieved 2026-09-15). Used in: core/principles.md.
- Anthropic, Claude's Character (anti-sycophancy, honesty, stopping when confused): https://www.anthropic.com/research/claude-character (retrieved 2026-09-15). Used in: AGENTS.md section 0 items 1 to 5.
- Sharma et al. (Anthropic), Towards Understanding Sycophancy in Language Models, arXiv:2310.13548: https://arxiv.org/abs/2310.13548 (retrieved 2026-09-15). Used in: the no-flattery rule.
- Anthropic engineering, Effective context engineering for AI agents (context rot, smallest set of high-signal tokens): https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents (retrieved 2026-09-15). Used in: lean injection policy, preset comments, README.
- Chroma, Context Rot (performance degrades as input grows, before the window is full): https://research.trychroma.com/context-rot (retrieved 2026-09-15). Used in: the lean-injection stance behind the preset patch, core/docs/evals.md cost reasoning.
- HumanLayer, Evolving AI Coding Agent Workflows from Research-Plan-Implement to CRISPY, ZenML LLMOps Database: https://www.zenml.io/llmops-database/evolving-ai-coding-agent-workflows-from-research-plan-implement-to-crispy (retrieved 2026-09-15). Used in: the CRISPY name and the phase structure in AGENTS.md section 2, and the argument that always-on prompt budget is scarce.
- Anthropic, prompt caching docs: https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching (retrieved 2026-09-15). Used in: CLAUDE.md prompt-caching-friendly structure.
- Anthropic, Claude Code skills (the tool-search pattern that skill_search and skill_load mirror): https://docs.anthropic.com/en/docs/claude-code/skills (retrieved 2026-09-15). Used in: skill-search.mjs, skills/ layout.
- ETH Zurich, arXiv:2602.11988 (instruction bloat raises inference cost roughly 20 to 23 percent): https://arxiv.org/abs/2602.11988 (retrieved 2026-09-15). Used in: preset patch, README design notes.

## Complexity, design, and maintainability
- T. J. McCabe, A Complexity Measure, IEEE Transactions on Software Engineering SE-2(4) (1976): https://doi.org/10.1109/TSE.1976.233837 (retrieved 2026-09-15). Used in: the cyclomatic budget in core/docs/complexity.md, 10 per function.
- G. A. Campbell, Cognitive Complexity: An Overview and Evaluation, ICPC (2018): https://doi.org/10.1145/3194164.3194186 (retrieved 2026-09-15). Used in: the cognitive budget in core/docs/complexity.md, 15 per function.
- Wily: High-Performance Complexity Gated-Feedback for AI Coding Agents, ACM Conference on AI and Agentic Systems (2026): https://doi.org/10.1145/3786335.3813220 (retrieved 2026-09-15). Used in: gating agent output on complexity metrics, core/docs/complexity.md and the review phase.
- zj-karina/complexity-budget, evidence-based complexity budgets: https://github.com/zj-karina/complexity-budget (retrieved 2026-09-15). Used in: the numeric budgets, 60 lines per function, 500 per file, 4 parameters, nesting 3; core/docs/complexity.md, core/principles.md.
- Robert C. Martin, Clean Code, chapters 1 and 3 (small functions, one thing per function, one level of abstraction, few arguments), ISBN 978-0132350884. Used in: the function-size, parameter, and nesting budgets, and the comment stance in core/docs/coding-standards.md.
- Martin Fowler, Refactoring, second edition, chapter 3 Bad Smells in Code, ISBN 978-0134757599: https://martinfowler.com/books/refactoring.html (retrieved 2026-09-15). Used in: the smell list in core/docs/maintainability.md.
- D. L. Parnas, On the Criteria To Be Used in Decomposing Systems into Modules, Communications of the ACM 15(12) (1972): https://doi.org/10.1145/361598.361623 (retrieved 2026-09-15). Used in: module boundaries and information hiding in core/docs/coupling.md and core/docs/architecture.md.
- E. Yourdon and L. Constantine, Structured Design (1978), ISBN 978-0138544713. Used in: coupling and cohesion criteria in core/docs/coupling.md and core/docs/maintainability.md.
- Robert C. Martin, Clean Architecture (2017), ISBN 978-0134494166. Used in: dependency direction rules in core/docs/coupling.md and core/docs/architecture.md.
- Early Career Developers' Perceptions of Code Understandability: A Study of Complexity Metrics, arXiv:2303.07722: https://arxiv.org/abs/2303.07722 (retrieved 2026-09-15). Used in: tracking two complexity metrics instead of one, core/docs/complexity.md.
- Microsoft, code metrics values (maintainability index): https://learn.microsoft.com/en-us/visualstudio/code-quality/code-metrics-values (retrieved 2026-09-15). Used in: the maintidx target in core/docs/languages/go.md and the measurement section of core/docs/maintainability.md.
- Wikipedia, Cyclomatic complexity (structure of the metric and its limits): https://en.wikipedia.org/wiki/Cyclomatic_complexity (retrieved 2026-09-15). Used in: the explanation of what the metric counts in core/docs/complexity.md.
- D. Knuth, Structured Programming with go to Statements, ACM Computing Surveys 6(4) (1974), the origin of measuring before optimizing: https://doi.org/10.1145/356635.356640 (retrieved 2026-09-15). Used in: the optimization rule in core/docs/performance.md.

## Process, operations, and debugging
- Google, Site Reliability Engineering, Postmortem Culture: https://sre.google/sre-book/postmortem-culture/ (retrieved 2026-09-15). Used in: the post-mortem section of core/docs/debugging.md and the review rules in AGENTS.md section 2.

## Testing
- Martin Fowler, The Practical Test Pyramid: https://martinfowler.com/articles/practical-test-pyramid.html (retrieved 2026-09-15). Used in: the unit, integration, and end-to-end split in core/docs/testing.md.
- Martin Fowler, Self-Testing Code: https://martinfowler.com/bliki/SelfTestingCode.html (retrieved 2026-09-15). Used in: tests as the precondition for refactoring, core/docs/testing.md.
- Kent Beck, Test-Driven Development: By Example (2002), ISBN 978-0321146533. Used in: test-first in AGENTS.md section 2 and core/docs/development-workflow.md.
- Michael Feathers, Working Effectively with Legacy Code (2004), ISBN 978-0131177055. Used in: characterization tests before changing untested code, core/docs/testing.md and core/docs/debugging.md.

## Security
- OWASP, Application Security Verification Standard: https://github.com/OWASP/ASVS (retrieved 2026-09-15). Used in: the verification requirements behind core/docs/security.md.
- OWASP, Top 10: https://owasp.org/www-project-top-ten/ (retrieved 2026-09-15). Used in: the risk list in core/docs/security.md.
- The Twelve-Factor App, factor III Config: https://12factor.net/config (retrieved 2026-09-15). Used in: secrets kept out of code and out of the repository, core/docs/security.md.
- OWASP, Dependency-Check: https://owasp.org/www-project-dependency-check/ (retrieved 2026-09-15). Used in: dependency scanning in the ci skill and core/docs/dependency-policy.md.

## Dependencies
- OpenSSF, Scorecard: https://github.com/ossf/scorecard (retrieved 2026-09-15). Used in: the health signals weighed before adopting a dependency, core/docs/dependency-policy.md.

## Git, commits, and releases
- Conventional Commits 1.0.0: https://www.conventionalcommits.org/en/v1.0.0/ (retrieved 2026-09-15). Used in: commit types in core/docs/git-workflow.md, AGENTS.md section 2, and the ship skill.
- Trunk Based Development: https://trunkbaseddevelopment.com/ (retrieved 2026-09-15). Used in: short-lived branches off main, core/docs/git-workflow.md.
- Google, Engineering Practices (code review): https://google.github.io/eng-practices/ (retrieved 2026-09-15). Used in: the review rules in AGENTS.md section 2 and the review skill.
- Michael Nygard, Documenting Architecture Decisions (2011): https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions (retrieved 2026-09-15). Used in: core/docs/decisions/ADR-template.md and the ADR conventions in core/docs/project-docs.md.
- Keep a Changelog 1.1.0: https://keepachangelog.com/en/1.1.0/ (retrieved 2026-09-15). Used in: core/templates/CHANGELOG.md and the changelog section of core/docs/project-docs.md.
- Semantic Versioning 2.0.0: https://semver.org/ (retrieved 2026-09-15). Used in: release tags in core/docs/git-workflow.md.

## Documentation standards
- Diataxis (Daniele Procida): https://diataxis.fr/ (retrieved 2026-09-15). Used in: the tutorial, how-to, reference, and explanation categories in core/docs/project-docs.md.
- Write the Docs, Docs as Code: https://www.writethedocs.org/guide/docs-as-code/ (retrieved 2026-09-15). Used in: the docs-as-code principle in core/docs/project-docs.md.

## Practitioner sources (stance and corroboration)
Writing by people who ship code with agents. These inform the posture of the config (review standards, discipline in tooling, memory as files) rather than backing a specific rule or number.
- Fabio Akita (akitaonrails), RANT: Did Akita Bend Over for AI? (2026): https://akitaonrails.com/en/2026/02/24/rant-akita-caved-to-ai/ (retrieved 2026-09-15). Stance the review rules follow: AI-assisted work carries the same standard as any other code.
- Fabio Akita, ai-memory: https://github.com/akitaonrails/ai-memory (retrieved 2026-09-15). Independent build of the same idea behind .ai/: agent memory as git-versioned markdown, with writes gated by evaluation.
- Robert C. Martin and Justin Martin, Clean AI: Agentic Discipline (2026): https://cleancoders.com/episode/agentic-discipline-6 (retrieved 2026-09-15). Corroborates the guardrails principle: discipline an agent cannot be trusted to remember belongs in the tooling.
- Matt Pocock, skills: https://github.com/mattpocock/skills (retrieved 2026-09-15). Reference implementation for a skills directory and its frontmatter.
- Simon Willison, weblog: https://simonwillison.net/ (retrieved 2026-09-15). Public record of what agent tooling does in practice, failure modes included.
- Martin Fowler, Exploring Generative AI: https://martinfowler.com/articles/exploring-gen-ai.html (retrieved 2026-09-15). Corroborates the review phase and the fresh-context idea.
- Kent Beck, Augmented Coding (Honeycomb episode 80): https://www.honeycomb.io/resources/podcasts/ep-80-augmented-coding-with-kent-beck (retrieved 2026-09-15). Corroborates test-first and small steps under AI assistance.

## Internal, measured
- Retained eval set (anchor checks plus task set): core/docs/evals.md. Anchor evidence: liangshen issue 6, 0/9 first-request anchoring with the skill catalog injected versus about 81 percent without. Used in: preset design decisions.
- The 2026-09 config review that drove the two preset swaps: summarized in the preset patch comments and core/docs/evals.md.
- Skill delivery scale policy: search and load stays the default while the catalog is small, and catalog injection is not reintroduced past roughly three to five skills. Basis: the anchor measurement above plus the instruction-budget entry.

## Repo design decisions
Decisions made here, with no external source. They are open to revision when evidence appears.
- Per-project .ai/ memory directory (ai-init, ai-context): this repo's own design.
- .ai/ holds agent memory, the committed docs/ holds documentation for humans; .ai/docs/ only carries genuine deviations from this config.
- AGENTS.md stays under 150 lines and points to core/docs/ for depth.
- A docs subdirectory appears once three files of the same type accumulate.
- Tool catalog injection is replaced by search and load, per the measurement above.
- Never git add -A; stage explicit files. Stated in AGENTS.md section 2 and enforced by the Claude Code hook.
- Skill triggers live in `description`, the only skill frontmatter field both harnesses read (Anthropic Claude Code skills; the dsh skill index). The separate `whenToUse` field was dropped as redundant, and the dsh search tolerates its absence.

## Community practice, uncited
- AGENTS.md / CLAUDE.md / cursorrules layering and project-root placement: 2026 consensus guides and widely used repos such as steipete/agent-rules. Standard practice; no single canonical paper.
- Dual frontmatter (description plus globs for Cursor; paths for Claude Code): the two vendors' own documentation.
- Language-specific rules and docs (go, python, rust, kotlin): distilled from those languages' official style guides and common practice.
- One assertion per test when practical (core/docs/testing.md).
- Time-box of three attempts or five minutes per simple issue (core/principles.md rule 9).
- Permission lists and pre-tool hooks as the enforcement layer for agent limits (README guardrails, agents/claude-code/settings.json).

## Repo provenance
When each file type entered the repository. Full history: git log --follow --diff-filter=A -- <path>.
- core/principles.md, core/docs/complexity.md, core/docs/testing.md, core/docs/security.md, core/docs/development-workflow.md, core/docs/project-docs.md, core/docs/ai-directory.md, core/docs/validation-checklist.md: 767d20e, 2026-08-03, initial commit.
- core/docs/sources.md: e028423, 2026-09-07, docs(sources): provenance for every rule, design choice, and threshold.
- core/docs/agent-config-authoring.md: d52217e, 2026-09-07, authoring spec plus the extend-config skill.
- core/docs/ai-writing.md: b29ae89, 2026-09-07, AI-writing tells checklist.
- core/docs/evals.md: 5b00a63, 2026-09-07, project docs refresh with the evals guide.
- The whole tree was regrouped under core/ and agents/ by the restructure of 2026-09-07, which is why the paths above differ from the original ones.

## Rule for future edits
- Every new behavioral rule or numeric threshold: add its source to this file in the same commit. If no source exists, label it repo design or community practice.
- Every web source carries a retrieval date.
- Cite the specific claim: name what the source justifies inside the file.
