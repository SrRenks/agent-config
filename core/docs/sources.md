# Sources and evidence (v2026-09-07)

Purpose: where each behavior rule, design choice, and numeric threshold in this config comes from. Add new claims only together with their source (see core/docs/agent-config-authoring.md, wiring checklist).

## Primary, cited
- Andrej Karpathy, llm-rigor principles (think before coding, surgical changes, minimum viable code, pushback scales with certainty): https://github.com/luiscrsilveira/llm-rigor . Used in: core/principles.md.
- Anthropic, Claude's Character (anti-sycophancy, honesty, stopping when confused): https://www.anthropic.com/research/claude-character . Used in: AGENTS.md section 0 items 1 to 5.
- Sharma et al. (Anthropic), Towards Understanding Sycophancy in Language Models, arXiv:2310.13548: https://arxiv.org/abs/2310.13548 . Used in: the no-flattery rule.
- Anthropic engineering, Effective context engineering for AI agents (context rot, smallest set of high-signal tokens): https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents . Used in: lean injection policy, preset comments, README.
- Anthropic, prompt caching docs: https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching . Used in: CLAUDE.md prompt-caching-friendly structure.
- Anthropic, Claude Code skills (the tool-search pattern that skill_search/skill_load mirrors): https://docs.anthropic.com/en/docs/claude-code/skills . Used in: skill-search.mjs, skills/ layout.
- ETH Zurich, arXiv:2602.11988 (instruction bloat raises inference cost roughly 20 to 23 percent): https://arxiv.org/abs/2602.11988 . Used in: preset patch, README design notes.
- Wikipedia, Signs of AI writing (WikiProject AI Cleanup): https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing . Used in: core/docs/ai-writing.md.
- ZenML LLMOps Database (HumanLayer), evolving agent workflows from RPI to CRISPY: https://www.zenml.io/llmops-database/evolving-ai-coding-agent-workflows-from-research-plan-implement-to-crispy . Used in: AGENTS.md section 2 CRISPY workflow.
- zj-karina/complexity-budget, evidence-based complexity budgets: https://github.com/zj-karina/complexity-budget . Used in: complexity budget rules, core/docs/complexity.md, core/principles.md.

- Robert C. Martin, Clean Code, chapter 4 Comments (comments compensate for a failure to express ourselves in code): https://www.oreilly.com/library/view/clean-code-a/9780136083238/ . Used in: coding-standards.md comment stance.
- Jeff Atwood, Coding Without Comments: https://blog.codinghorror.com/coding-without-comments/ . Used in: same.
- Kevlin Henney, Seven Ineffective Coding Habits of Many Programmers, BUILD STUFF'14 (a comment is a lie waiting to happen): https://www.slideserve.com/Kevlin/seven-ineffective-coding-habits-of-many-programmers . Used in: same.
- John Ousterhout, A Philosophy of Software Design, chapter 13 (comments should describe what is not obvious from the code; interface comments beat self-documenting code alone): https://web.stanford.edu/~ouster/cgi-bin/book.php . Used in: docstring-first policy; the counterpoint to comment-free code.
- Google style guides, Python docstrings and C++ comments: https://google.github.io/styleguide/pyguide.html . Used in: docstring policy.
## Internal, measured
- Retained eval set (anchor checks plus task set): core/docs/evals.md. Anchor evidence: liangshen issue 6, 0/9 first-request anchoring with the skill catalog injected versus about 81 percent without. Used in: preset design decisions.
- The 2026-09 config review that drove the two preset swaps: summarized in the preset patch comments and docs/evals.md.

## Community practice, uncited
- AGENTS.md / CLAUDE.md / .cursorrules layering and project-root placement: 2026 consensus guides and widely used repos such as steipete/agent-rules. Standard practice; no single canonical paper.
- Per-project .ai/ memory directory (ai-init, ai-context): this repo's own design.
- Dual frontmatter (description plus globs for Cursor; paths for Claude Code): the two vendors' own documentation.
- Language-specific rules and docs (go, python, rust, kotlin): distilled from those languages' official style guides and common practice.

## Rule for future edits
- Every new behavioral rule or numeric threshold: add its source to this file in the same commit. If no source exists, label it community practice.
