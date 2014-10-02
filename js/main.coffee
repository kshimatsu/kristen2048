randomInt = (x) ->
  Math.floor(Math.random() * x)

buildBoard = ->
  # board = []
  # for row in [0..3]
  #   board[row] = []
  #   for column in [0..3]
  #       board[row][column] = 0
  # board
  [0..3].map -> [0..3].map -> 0

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2, 2, 2, 4]
  values[randomInt(4)]

generateTile = (board) ->
  value = randomValue()
  [row, column] = randomCellIndices()
  console.log "row: #{row} / col: #{column}"

  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)

  console.log "generate tile"

move = (board, direction) ->

  for i in [0..3]
    if direction is 'right'
      row = getRow(i, board)
      mergeCells(row, direction)
      collapseCells()

getRow = (r, board) ->
  console.log 'get row'
  # boardArray[index]
  [board[r][0], board[r][1], board[r][2], board[r][3]]

mergeCells = (row, direction)->
  if direction is 'right'
    for a in [3...0]
      for b in [a-1..0]
        console.log a, b

        if row[a] is 0
          console.log 'cell is 0'
          break
        else if row[a] == row[b]
          console.log 'cells are the same'
          row[a] *= 2
          row[b] = 0
          break
        else if row[b] isnt 0
          console.log 'different'
          break
        else if row[b] == 0
          console.log 'different again'


  row

collapseCells = (row, direction) ->
  # Remove '0'
  row = row.filter (x) -> x isnt 0
  # Adding '0'
  if direction is 'right'
    while row.length < 4
      row.unshift 0
  row

console.log mergeCells [4, 0, 2, 0], 'right'

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      $(".r#{row}.c#{col} > div").html(board[row][col])
  console.log "show board"

printArray =  (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "-- End --"


$ ->
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  showBoard(@board)

  $('body').keydown (e) =>
    e.preventDefault()

    key = e.which
    keys = [37..40]

    if key in keys > -1
      # continue the game
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'

      # try moving
      move(@board, direction)
      # check the move validity
    else
      # do nothing

