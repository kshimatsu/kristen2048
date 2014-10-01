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

generateTile = ->
  value = 2
  console.log "randomInt: #{randomInt(4)}"
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

