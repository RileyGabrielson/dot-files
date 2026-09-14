#let ink = rgb("#111111")
#let muted = rgb("#5a5a5a")
#let rule = rgb("#b0b0b0")

#set page(paper: "us-letter", margin: (x: 0.62in, top: 0.5in, bottom: 0.5in))
#set text(font: "Charter", size: 10pt, fill: ink)
#set par(leading: 0.6em)
#show link: set text(fill: rgb("#1f4e79"))

#let section(title) = {
  v(0.75em)
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
  set list(marker: text(fill: muted)[•], indent: 0.2em, body-indent: 0.5em, spacing: 0.5em)
  list(..items)
}

#let skill(label, body) = {
  grid(
    columns: (5.5em, 1fr),
    gutter: 0.6em,
    text(weight: "bold")[#label], body,
  )
  v(0.25em)
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
  [Founded and lead the Business Intelligence team, owning the analytics product end to end — query authoring, dashboards, scheduled report delivery, and export — and growing it from a single feature into a platform other product teams build on.],
  [Designed and built *Insight Builder*, a node-graph query editor where non-technical users compose joins, derivations, filters, and aggregations on a visual canvas that compiles to executable SQL, paired with a grammar-aware guided expression editor offering contextual function, parameter, and literal suggestions.],
  [Architected the embeddable dashboard platform: packaged BI as a versioned npm library and a shadow-DOM–isolated plugin bundle, letting any team drop live analytics into their own application without a BI deploy or CSS collisions.],
  [Co-architected the company's micro-frontend platform — independently released runtime services for OIDC authentication across regions, routing, plugin loading, rendering, and logging — and wrote the CI tooling that enforces service interface types and blocks breaking changes across consumers.],
  [Shipped a client-side analytics engine on DuckDB-WASM, querying Parquet over HTTPS in the browser to cut dashboard interaction latency and take repeat aggregation load off the backend.],
  [Merged 1,700+ changes and reviewed 1,000+ more from teammates, setting the frontend conventions, presenter-pattern architecture, and keyboard-accessibility standards the organization builds against.],
)

#entry[Bad Crow Games][Technical Lead & Game Designer][February 2019 — August 2021]

#bullets(
  [Built the studio's websites and wrote automation scripts that took repetitive production work off the team.],
  [Designed and built a solo and cooperative system in which players face a rules-driven AI opponent, extending competitive titles to single-player and full-table co-op without a human adversary.],
  [Designed game systems and mechanics for the studio's titles.],
)

#section[Education]

#entry[Brigham Young University][B.S. Applied and Computational Mathematics][September 2018 — May 2022]

#bullets(
  [Emphasis on numerical methods, optimization, and algorithm design; worked as a technical lead in industry throughout the degree.],
)

#section[Technologies & Languages]

#skill[Languages][TypeScript, JavaScript, Python, SQL, PRQL, GDScript]
#skill[Frontend][React, micro-frontends, Web Components & Shadow DOM, design systems, Storybook, Vite]
#skill[Backend][API design, gRPC & Protocol Buffers, REST, Node.js, DuckDB]
#skill[Practice][Full-stack architecture, plugin systems, monorepos, semantic release, CI/CD, technical leadership]
