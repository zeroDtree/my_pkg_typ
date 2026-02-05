/// Renders a grid table where specific columns are automatically
/// highlighted based on min/max rules.
///
/// - headers: Array of content for the table header.
/// - data: 2D Array of data. Cells can be values, arrays (val, err), or text.
/// - rules: Dictionary mapping column indices (int) to "min" or "max".
/// - cols: Grid column definitions (e.g., (1fr, 1fr)).
/// - align: Alignment for cells.
/// - inset: Inset padding for cells.
#let highlight-table(
  headers: (),
  data: (),
  rules: (:),
  cols: auto,
  align: center + horizon,
  inset: 0.5em,
) = {
  // 1. Helper: Extract the numeric value for comparison
  let get-value(cell) = {
    if type(cell) == array { cell.at(0) } else { cell }
  }

  // 2. Pre-calculate targets (min or max) for specified columns
  let targets = (:)
  for (col-idx, rule) in rules {
    let col-values = data.map(row => get-value(row.at(int(col-idx))))
    let target = if rule == "min" {
      calc.min(..col-values)
    } else if rule == "max" {
      calc.max(..col-values)
    }
    targets.insert(str(col-idx), target)
  }

  // 3. Helper: Format cell content (handle standard deviation)
  let format-cell(cell) = {
    if type(cell) == array {
      // Assumes format: (value, error)
      $#cell.at(0) plus.minus #cell.at(1)$
    } else if type(cell) == float or type(cell) == int {
      $#cell$
    } else {
      cell
    }
  }

  // 4. Render the Grid
  grid(
    columns: if cols == auto { (1fr,) * headers.len() } else { cols },
    align: align,
    inset: inset,

    // Render Headers
    grid.hline(),
    ..headers.map(h => strong(h)),
    grid.hline(),
    // Render Data
    ..data
      .map(row => {
        row
          .enumerate()
          .map(((col-idx, cell)) => {
            let val = get-value(cell)
            let content = format-cell(cell)
            let target = targets.at(str(col-idx), default: none)

            // Apply bold if value matches the target
            if target != none and val == target {
              strong(content)
            } else {
              content
            }
          })
      })
      .flatten(),
    grid.hline()
  )
}


// 1. Define Data
#let my-headers = ([Model], [Vina Score], [QED], [LogP])
#let my-data = (
  ("DEPACT", (-6.632, 0.18), 0.45, 2.1),
  ("dyMEAN", (-6.855, 0.06), 0.62, 3.5),
  ("FAIR", (-7.015, 0.12), 0.55, 1.8),
  ("RFDiffusion", (-6.936, 0.07), 0.48, 2.9),
  ("PocketGen", (-7.135, 0.08), 0.78, 3.1),
  ("DiffPocket", (-7.599, 0.15), 0.60, 2.5),
)

// 2. Define Rules (Column Index : "min" or "max")
// Index 1 = Vina Score (min is better)
// Index 2 = QED (max is better)
// Index 3 = LogP (max is better)
#let my-rules = (
  "1": "min",
  "2": "max",
  "3": "max",
)

// 3. Call Function
#highlight-table(
  headers: my-headers,
  data: my-data,
  rules: my-rules,
  cols: (1.5fr, 1fr, 1fr, 1fr),
)
