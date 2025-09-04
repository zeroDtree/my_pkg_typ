#let checkbox(checked: false) = {
  if checked {
    box(
      stroke: .05em,
      height: .8em,
      width: .8em,
      {
        box(
          move(
            dy: .48em,
            dx: 0.1em,
            rotate(45deg, reflow: false, line(length: 0.3em, stroke: .1em)),
          ),
        )
        box(
          move(
            dy: .38em,
            dx: -0.05em,
            rotate(-45deg, reflow: false, line(length: 0.48em, stroke: .1em)),
          ),
        )
      },
    )
  } else {
    box(
      stroke: .05em,
      height: .8em,
      width: .8em,
    )
  }
}
