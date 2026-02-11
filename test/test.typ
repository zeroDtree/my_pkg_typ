#import "@preview/cetz:0.4.2"
#import "@local/ls_kit:0.1.0"
#cetz.canvas({
  import cetz.draw: *
  circle((0, 0), name: "c")
  fill(red)
  circle((v => cetz.vector.add(v, (0, -1)), "c.west"), radius: 0.3)
})
