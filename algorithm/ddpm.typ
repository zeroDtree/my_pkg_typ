#import "@preview/fletcher:0.5.8" as fletcher: *
#let DDPM = diagram(
  node-stroke: 0.1em,
  node-fill: gradient.radial(
    blue.lighten(80%),
    blue,
    center: (30%, 20%),
    radius: 80%,
  ),
  spacing: 4em,
  node((0, 0), [$x_0$], radius: 1.5em),
  edge("-|>", [$q(x_1|x_0)$]),
  node((1, 0), [$x_1$], radius: 1.5em),
  edge("--|>"),
  node((2, 0), [$x_(t-1)$], radius: 1.5em),
  edge("-|>", [$q(x_(t)|x_(t-1))$]),
  node((3, 0), [$x_t$], radius: 1.5em),
  edge("--|>"),
  node((4, 0), [$x_T$], radius: 1.5em),
  edge((3, 0), (2, 0), "-|>", [$p_(theta)(x_(t-1)|x_t)$], bend: 30deg),
)

#DDPM