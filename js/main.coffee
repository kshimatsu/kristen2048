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
  newBoard = buildBoard()

  for i in [0..3]
    if direction is 'right' or 'left'
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)

  newBoard

getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]

setRow = (row, index, board) ->
  board[index] = row


mergeCells = (row, direction)->
  if direction is 'right'
    for a in [3...0]
      for b in [a-1..0]

        if row[a] is 0
          break
        else if row[a] == row[b]
          row[a] *= 2
          row[b] = 0
          break
        else if row[b] isnt 0
          break

  else if direction is 'left'
    for a in [0...3]
      for b in [a+1..3]

        if row[a] is 0
          break
        else if row[a] == row[b]
          row[a] *= 2
          row[b] = 0
          break
        else if row[b] isnt 0
          break
  row



collapseCells = (row, direction) ->
  # Remove '0'
  row = row.filter (x) -> x isnt 0
  # Adding '0'
  if direction is 'right'
    while row.length < 4
      row.unshift 0
  else if direction is 'left'
    while row.length < 4
      row.push 0
  row

moveIsValid = (originalBoard, newBoard) ->
  for row in [0..3]
    for col in [0..3]
      if originalBoard[row][col] isnt newBoard[row][col]
        return true # return is to stop the entire function, break will just break the interior

  false

boardIsFull = (board) ->
  for row in board
    if 0 in row
        return false
  true

noValidMoves = (board) ->
  direction = 'right' or 'left' # fix me, handle other directions
  newBoard = move(board, direction)
  if moveIsValid(board, newBoard)
    return false
  true

isGameOver = (board) ->
  boardIsFull(board) and noValidMoves(board)

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

    if key in keys
      e.preventDefault()
      # continue the game
      console.log "key: ", key
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'

      # try moving
      newBoard = move(@board, direction)
      printArray(newBoard)
      # check the move validity
      if moveIsValid(@board, newBoard)
        console.log "valid"
        @board = newBoard
        # generate tile
        generateTile(@board)
        # show board
        showBoard(@board)
        # check game lost
        if isGameOver(@board)
          console.log "Game over!!"
        else
          # show board
          showBoard(@board)
      else
        console.log "invalid"
    else
      # do nothing

