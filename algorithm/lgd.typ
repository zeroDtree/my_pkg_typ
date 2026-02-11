#import "@preview/fletcher:0.5.8" as fletcher: *

#let LGD = diagram(
  node-stroke: 0.8pt,
  node-fill: white,
  edge-stroke: 0.8pt,
  spacing: (0.1cm, 1.2cm),
  // 定义节点
  node((1, 0), [$x_t$], shape: rect, name: "xt"),
  node((2, 1), [Denoiser], shape: rect, name: "denoiser"),
  node((3, 1), [Predicted Unconditional Score], name: "pus"),
  node((3, 0), [Posterior Mean], shape: rect, name: "pm"),
  node((4, 1), [$E[x_0|x_t]$], name: "ex0xt"),
  node((4, 2), [attribute map], shape: rect, name: "am"),
  node((5, 2), [condition y], name: "cy"),
  node((4, 3), [condition loss function], shape: rect, name: "closs"),
  node((3, 3), [Predicted Conditional Score], name: "pcs"),
  node((3, 2), [$+$], shape: circle, name: "plus"),
  node((2, 2), [Predicted Score], name: "ps"),
  node((2, 3), [Sampler], shape: rect, name: "sampler"),
  node((1, 3), [$x_(t-1)$], shape: rect, name: "xt1"),

  // // 主要连接
  edge(<xt>, <denoiser>, "->", corner: right),
  edge(<denoiser>, <pus>, "->"),
  edge(<pus>, <pm>, "->"),
  edge(<xt>, <pm>, "->"),
  edge(<pm>, <ex0xt>, "->", corner: right),
  edge(<ex0xt>, <am>, "->"),
  edge(<am>, <closs>, "->"),
  edge(<cy>, <closs>, "->", corner: right),
  edge(<closs>, <pcs>, "->"),
  edge(<pcs>, <plus>, "->"),
  edge(<pus>, <plus>, "->"),
  edge(<plus>, <ps>, "->"),
  edge(<ps>, <sampler>, "->"),
  edge(<sampler>, <xt1>, "->"),
  edge(<xt1>, <xt>, "-->"),
)

#LGD
