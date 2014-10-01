buildBoard = ->
  board = []
  for row in [0..3]
      # console.log "row: ", row
      board[row] = []

      for column in [0..3]
          board[row][column] = 0
          # console.log "column: ", column

      # console.log "board: ", board
  # console.log board
  console.log "build board"
  board

generateTile = ->
  console.log "generate tile"

printArray =  (array) ->
  console.log "-- Start --"
  for row in array
      console.log row
  console.log "-- End --"


$ ->

  newBoard = buildBoard()
  printArray(newBoard)
  generateTile()
  generateTile()

