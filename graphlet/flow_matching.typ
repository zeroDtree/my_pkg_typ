#import "@preview/cetz:0.4.2" as cetz: canvas, draw
#import draw: circle, content, line

#let flow_matching() = {
  cetz.canvas({
    import cetz.draw: *
    ortho(x: -60deg, y: -45deg, z: 0deg, {
      // 1. 全局样式设置
      let source-color = orange.lighten(20%)
      let target-color = blue.darken(10%)
      let field-color = black.lighten(40%)
      let trajectory-color = red.darken(10%)

      // 2. 绘制背景参考网格
      grid(
        (-4, -4),
        (4, 4),
        step: 1,
        stroke: luma(240),
      )

      // 3. 绘制源分布 p_0 (高斯噪声)
      circle((0, 0, 0), radius: 1.5, fill: source-color.transparentize(80%), stroke: (
        paint: source-color,
        dash: "dashed",
      ))
      content((0, 0, -3), text(fill: source-color)[源分布 $p_0$ (噪声)])

      // 4. 绘制目标分布 p_1 (数据)
      // 假设数据分布在右上角的一个小区域
      let data-center = (2.5, 2.5, 2.5)
      circle(data-center, radius: 0.8, fill: target-color.transparentize(80%), stroke: target-color)
      content((4, 4, 5), text(fill: target-color)[目标分布 $p_1$ (数据)])

      // 5. 绘制向量场 (Vector Field)
      // 流量匹配学习的是从 x_0 到 x_1 的速度向量 v_t
      let scale = 0.2 // 箭头缩放比例
      for x in range(-3, 4) {
        for y in range(-3, 4) {
          for z in range(-3, 4) {
            let px = float(x)
            let py = float(y)
            let pz = float(z)

            // 计算指向目标的向量
            let dx = (data-center.at(0) - px) * scale
            let dy = (data-center.at(1) - py) * scale
            let dz = (data-center.at(2) - py) * scale

            let dist = calc.sqrt(
              calc.pow(data-center.at(0) - px, 2)
                + calc.pow(data-center.at(1) - py, 2)
                + calc.pow(data-center.at(2) - pz, 2),
            )

            if dist > 0.5 and dist < 5 {
              line(
                (px, py, pz),
                (rel: (dx, dy)),
                mark: (end: "stealth", fill: field-color, scale: 0.4),
                stroke: field-color + 0.4pt,
              )
            }
          }
        }
      }

      // 6. 绘制示例轨迹 (Sample Trajectories)
      let samples = ((-1, -0.5, 0), (0.5, -1.2, 0), (-0.8, 1, 0))
      for s in samples {
        // 绘制起点
        circle(s, radius: 0.05, fill: source-color)
        // 绘制直线轨迹
        line(s, data-center, stroke: (paint: trajectory-color, thickness: 0.8pt, dash: "dotted"))
        // 绘制终点（在目标区域内随机偏置一点）
        circle(
          (
            data-center.at(0) + (s.at(0) * 0.1),
            data-center.at(1) + (s.at(1) * 0.1) + data-center.at(2) + (s.at(2) * 0.1),
          ),
          radius: 0.05,
          fill: target-color,
        )
      }

      // 7. 标注向量 v_t(x)
      content((-2.5, 2.5, 2), text(fill: blue.darken(20%))[学习到的向量场 $v_t (x)$])
    })
  })
}

#flow_matching()
