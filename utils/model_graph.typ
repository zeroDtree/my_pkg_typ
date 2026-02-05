#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: brace, diamond, hexagon, house, parallelogram, pill

#let io_node_args(dir) = {
  (shape: house.with(angle: 30deg, dir: dir), fill: red.lighten(60%), stroke: red.darken(20%))
}
#let module_node_args = (shape: rect, fill: gray.lighten(60%), stroke: gray.darken(20%))
#let enclose_node_args = (shape: rect, inset: 0.5em, stroke: 2pt + purple.lighten(60%))
#let operator_node_args = (shape: circle, fill: yellow.lighten(60%), stroke: yellow.darken(20%))
#let function_node_args = (shape: hexagon, fill: green.lighten(60%), stroke: green.darken(20%))
#let ffn_node_args = (shape: rect, fill: blue.lighten(60%), stroke: blue.darken(20%), corner-radius: 5pt)
#let mha_node_args = (shape: rect, fill: orange.lighten(60%), stroke: orange.darken(20%), corner-radius: 5pt)

#let edge_args = (marks: "-|>", label-side: center)
#let residual_edge_args = (
  marks: "--|>",
  label-side: center,
  label-wrapper: edge => box(
    [#edge.label],
    inset: .2em,
    radius: .2em,
    fill: edge.label-fill,
  ),
)


#diagram(
  spacing: 0.8em,
  node(
    (-1, 0.5),
    [
      Invariant\ Encoder
    ],
    name: "invariant_encoder",
    ..module_node_args,
  ),
  node(
    (1, 0.5),
    [ #set par(leading: 1em)
      #v(4em)
      Equivariant\ Decoder
      #v(4em)
    ],
    name: "equivariant_decoder",
    ..module_node_args,
  ),
  node((-3, -0.2), [Ligand], shape: rect, name: "ligand", ..io_node_args(right)),
  node((-3, 0.3), [Timestep], shape: rect, name: "t", ..io_node_args(right)),
  node((-3, 0.7), [Protein], shape: rect, name: "protein", ..io_node_args(right)),
  node((-3, 1.3), [Pocket], shape: rect, name: "pocket", ..io_node_args(right)),
  node((4, 4), [softmax], ..function_node_args),
  node((2, 4), [Feed Forward], ..ffn_node_args),
  node((3, 5), [Multi Head Attention], ..mha_node_args),
  node(
    (3, 0.5),
    [Updated\
      Protein],
    shape: rect,
    name: "u_p",
    ..io_node_args(right),
  ),
  node((3, 3), $+$, ..operator_node_args),
  edge(<pocket>, "d,rrrr", <equivariant_decoder>, ..residual_edge_args, label: [cancha]),
  edge(<protein>, "rr", ..edge_args),
  edge(<ligand>, "rr", ..edge_args),
  edge(<t>, "rr", ..edge_args),
  edge(<pocket>, "rr", ..edge_args),
  edge(<invariant_encoder>, <equivariant_decoder>, ..edge_args),
  edge(<equivariant_decoder>, <u_p>, ..edge_args),
  node(enclose: (<ligand>, <t>, <protein>, <pocket>), ..enclose_node_args),
)

