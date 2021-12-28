include karax/prelude
import algorithm

var 
  status: array[0..8,kstring]
  xIsNext: bool = true
  winner: kstring = kstring""

status.fill(kstring"")

proc calculateWinner(): kstring =
  const lines = @[
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
  ]
  for i in lines:
    var a, b, c: int
    (a, b, c) = i
    if status[a] != kstring"" and status[a] == status[b] and status[a] == status[c]:
      return status[a]
  return ""

proc square(m: int): VNode =
  proc squareOnClick(a: int): proc() = 
    return proc() =
      if winner != kstring"": return
      status[a] = if xIsNext: kstring"x" else:kstring"o"
      xIsNext = not xIsNext
      winner = calculateWinner()

  return buildHTML(tdiv):
    button(class = "square",onclick = squareOnClick(m)):
        text status[m]

proc board(): VNode =
  return buildHtml(tdiv):
    for i in 0..2:
      tdiv(class = "board-row"):
        for j in 0..2:
          square(i*3+j)

proc createDom(): VNode =
  return buildHtml(tdiv):
    board()
    tdiv(class = "container"):
      tdiv:
        if winner == "":
          text "Next: " & (if xIsNext:"x" else:"o")
        else:
          text "Winner: " & winner


setRenderer createDom