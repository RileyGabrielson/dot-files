#let ink = rgb("#111111")
#let muted = rgb("#5a5a5a")
#let rule = rgb("#b0b0b0")

#set page(paper: "us-letter", margin: (x: 0.62in, top: 0.45in, bottom: 0.4in))
#set text(font: "Charter", size: 10pt, fill: ink)
#set par(leading: 0.52em)
#show link: set text(fill: rgb("#1f4e79"))

#let section(title) = {
  v(0.7em)
  text(size: 9.5pt, weight: "bold", tracking: 0.12em)[#upper(title)]
  v(-0.5em)
  line(length: 100%, stroke: 0.5pt + rule)
  v(-0.15em)
}

#let entry(org, role, dates) = {
  v(0.35em)
  grid(
    columns: (1fr, auto),
    align: (left, right),
    [#text(weight: "bold", size: 10.5pt)[#org]#text(fill: muted)[ · ]#text(style: "italic")[#role]],
    text(fill: muted, size: 9.5pt)[#dates],
  )
  v(-0.3em)
}

#let bullets(..items) = {
  set list(marker: text(fill: muted)[•], indent: 0.2em, body-indent: 0.5em, spacing: 0.7em)
  list(..items)
}

#let skill(label, body) = {
  grid(
    columns: (5.5em, 1fr),
    gutter: 0.6em,
    text(weight: "bold")[#label], body,
  )
  v(0.2em)
}

#align(center)[
  #text(size: 21pt, weight: "bold", tracking: 0.02em)[Riley Aaron Gabrielson]
  #v(-0.35em)
  #text(size: 10.5pt, fill: muted)[Staff Software Engineer]
  #v(-0.25em)
  #text(size: 9.5pt, fill: muted)[
    rileygabrielson\@gmail.com · (435) 671-7282 · Orem, UT · #link("https://github.com/RileyGabrielson")[github.com/RileyGabrielson]
  ]
]

#section[Work Experience]

#entry[TCN][Staff Software Engineer][August 2021 — Present]

#bullets(
  [Founded and lead the Business Intelligence team for TCN's cloud contact-center platform, owning analytics end to end — query authoring, dashboards, scheduled delivery of 100,000+ reports, and export — and growing it from a single feature into a platform other product teams embed.],
  [Coached and mentored dozens of engineers, and facilitated and taught engineering principles and lessons across the company.],
  [Co-architected the micro-frontend platform — independently released runtime services for OIDC authentication, routing, plugin loading, rendering, and logging — and wrote the CI tooling enforcing interface types and blocking breaking changes across consumers.],
  [Owned the analytics data path end to end — schema and query modeling, two-phase query execution, request deduplication, and result-size gating — serving millions of queries across thousands of insights.],
  [Shipped a client-side analytics engine on DuckDB-WASM querying Parquet over HTTPS, plus real-time dashboard panels fed by concurrent gRPC server streams into DuckDB event tables.],
  [Drove agentic-AI adoption across engineering — authored the org's shared Claude Code instruction set and automation skills — and reviewed 1,000+ merge requests holding generated and hand-written code to one bar for correctness, security, and maintainability.],
  [Set the team's testing and architecture standards: dependency-injected unit and component tests over global mocks, presenter-pattern separation of logic from view, and fully keyboard-accessible UI.],
  [Balanced input from UX designers, business stakeholders, and engineers on adjacent teams — translating design specs and requirements into technical direction, and holding it together across a varied technology stack.],
)

#entry[Bad Crow Games][Technical Lead & Game Designer][February 2019 — August 2021]

#bullets(
  [Built the studio's websites and wrote automation scripts that took repetitive production work off the team.],
  [Designed and built a solo and cooperative system in which players face a rules-driven AI opponent, extending competitive titles to single-player and full-table co-op.],
)

#section[Education]

#entry[Brigham Young University][B.S. Applied and Computational Mathematics][September 2018 — May 2022]

#section[Technologies & Languages]

#skill[Languages][TypeScript, JavaScript, Go, Python, SQL, PRQL, GDScript]
#skill[Frontend][React, Svelte 5, micro-frontends, Web Components & Shadow DOM, design systems, accessibility]
#skill[Backend][API design, gRPC & Protocol Buffers, REST, server streaming, Node.js, DuckDB, data modeling]
#skill[Platform][GCP, GitLab CI/CD, Git branching strategies, monorepos, semantic release]
#skill[Practice][Full-stack architecture, plugin systems, technical leadership, mentorship, testing, agentic AI]
