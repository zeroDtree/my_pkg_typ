#import "@preview/cetz:0.4.2": canvas, draw
#import draw: circle, content, line, rect

#let atom(pos, element, color: white, text-color: black, padding: 6pt, name: none) = {
  // Calculate the radius based on padding to match the original size
  let radius = padding + 7pt // Approximation of text size + padding

  // Draw base circle with the main color
  circle(
    pos,
    radius: radius,
    stroke: none,
    fill: color,
  )

  // Draw gradient overlay for 3D shading effect
  circle(pos, radius: radius, stroke: none, fill: gradient.radial(
    color.lighten(75%),
    color,
    color.darken(15%),
    focal-center: (30%, 25%),
    focal-radius: 5%,
    center: (35%, 30%),
  ))

  // Draw the element text on top
  content(
    pos,
    text(fill: text-color, weight: "bold", size: 14pt)[#element],
    anchor: "center",
    name: name,
  )
}

#let small_mole(length: 5em, scale: 1) = {
  canvas(
    length: length,
    {
      // Define styles
      let arrow-style = (
        stroke: rgb("#888") + 5pt,
        mark: (end: "stealth", size: 15pt),
      )

      // Set vertical center point for all elements
      let vertical-center = 0

      // Define spacing constants
      let struct-desc-spacing = 2.5 // Closer spacing between structure and descriptor
      let model-prop-spacing = 2.5 // Closer spacing between model and property
      let component-spacing = 3.5 // Spacing between other components
      let label-offset = 4 // Vertical distance from components to labels
      let label-y = vertical-center - label-offset // Fixed y-position for all labels

      // Define vertical offsets
      let molecule-y-offset = 0.5 // Move molecule up
      let matrix-y-offset = 0.3 // Move matrix up

      // Define component positions
      let struct-x = -5.5
      let struct-y = vertical-center + molecule-y-offset
      let struct-origin = (struct-x, struct-y)

      // Draw molecular structure
      // Bonds first (so atoms appear on top)
      line(
        (rel: (1.5, -2.5), to: struct-origin),
        (rel: (0, -1.5), to: struct-origin),
        stroke: rgb("#888") + 3pt,
        name: "bond1",
      )
      line(
        (rel: (0, -1.5), to: struct-origin),
        struct-origin,
        stroke: rgb("#888") + 3pt,
        name: "bond2",
      )
      line(
        struct-origin,
        (rel: (-0.5, 1.5), to: struct-origin),
        stroke: rgb("#888") + 3pt,
        name: "bond3",
      )
      line(
        struct-origin,
        (rel: (1.8, 0.5), to: struct-origin),
        stroke: rgb("#888") + 3pt,
        name: "bond4",
      )
      line(
        (rel: (0, -3), to: struct-origin),
        (rel: (0, -1.5), to: struct-origin),
        stroke: rgb("#888") + 3pt,
        name: "bond5",
      )
      line(
        (rel: (-1.5, -2.5), to: struct-origin),
        (rel: (0, -1.5), to: struct-origin),
        stroke: rgb("#888") + 3pt,
        name: "bond6",
      )
      line(
        (rel: (-0.5, 1.5), to: struct-origin),
        (rel: (-2, 0.75), to: struct-origin),
        stroke: rgb("#888") + 3pt,
        name: "bond7",
      )
      line(
        (rel: (-0.5, 1.5), to: struct-origin),
        (rel: (1, 2), to: struct-origin),
        stroke: rgb("#888") + 3pt,
        name: "bond8",
      )

      // Now draw atoms on top of bonds - with increased size
      // Carbon atoms
      atom(struct-origin, "C", color: rgb("#404040"), text-color: white, name: "C1", padding: 5pt * scale)
      atom(
        (rel: (0, -1.5), to: struct-origin),
        "C",
        color: rgb("#404040"),
        text-color: white,
        name: "C2",
        padding: 5pt * scale,
      )

      // Nitrogen atom
      atom((rel: (-0.5, 1.5), to: struct-origin), "N", color: rgb("#4444ff"), name: "N1", padding: 6pt * scale)

      // Oxygen atom
      atom((rel: (1.8, 0.5), to: struct-origin), "O", color: rgb("#ff4444"), name: "O1", padding: 7pt * scale)

      // Hydrogen atoms
      atom((rel: (1.5, -2.5), to: struct-origin), "H", color: white, padding: 2pt * scale, name: "H1")
      atom((rel: (0, -3), to: struct-origin), "H", color: white, padding: 2pt * scale, name: "H2")
      atom((rel: (-1.5, -2.5), to: struct-origin), "H", color: white, padding: 2pt * scale, name: "H3")
      atom((rel: (-2, 0.75), to: struct-origin), "H", color: white, padding: 2pt * scale, name: "H4")
      atom((rel: (1, 2), to: struct-origin), "H", color: white, padding: 2pt * scale, name: "H5")
    },
  )
}

#small_mole(length: 2em, scale: 0.1)
