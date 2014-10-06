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
    if direction in ['right', 'left']
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)
    else if direction in ['down', 'up']
      column = getColumn(i, board)
      column = mergeCells(column, direction)
      column = collapseCells(column, direction)
      setColumn(column, i, newBoard)
  newBoard

getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]

setRow = (row, index, board) ->
  board[index] = row

getColumn = (c, board) ->
  [board[0][c], board[1][c], board[2][c], board[3][c]]


setColumn = (column, index, board) ->
  for i in [0..3]
    board[i][index] = column[i]


mergeCells = (cells, direction)->

  merge = (cells) ->
    for a in [3...0]
      for b in [a-1..0]
        if cells[a] is 0
          break
        else if cells[a] == cells[b]
          cells[a] *= 2
          cells[b] = 0
          break
        else if cells[b] isnt 0
          break
        else if cells[b] isnt 0 then break
    cells

  if direction in ['right', 'down']
    cells = merge(cells)
  else if direction in ['left', 'up']
    cells = merge(cells.reverse()).reverse()

  cells

  # else if direction is 'left'
  #   for a in [0...3]
  #     for b in [a+1..3]

  #       if row[a] is 0
  #         break
  #       else if row[a] == row[b]
  #         row[a] *= 2
  #         row[b] = 0
  #         break
  #       else if row[b] isnt 0
  #         break

collapseCells = (row, direction) ->
  # Remove '0'
  row = row.filter (x) -> x isnt 0
  # Adding '0'
  while row.length < 4
    if direction in ['right', 'down']
      row.unshift 0
    else if direction in ['left', 'up']
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
  for direction in ['up', 'down', 'left', 'right']
    newBoard = move(board, direction)
    if moveIsValid(board, newBoard)
      return false
  true

isGameOver = (board) ->
  boardIsFull(board) and noValidMoves(board)

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      for power in [1..11]
        $(".r#{row}.c#{col}").removeClass('val-' + Math.pow(2, power))
      if board[row][col] is 0
        $(".r#{row}.c#{col} > div").html('')
      else
        $(".r#{row}.c#{col} > div").html(board[row][col])
        $(".r#{row}.c#{col}").addClass('val-' + board[row][col])


printArray =  (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "-- End --"

restartGame = () ->
  window.location.reload();

randomQuote = () ->
  quotes = [
    "fetch",
    "None for Gretchen Weiners",
    "So you think you're really pretty",
    "You can't sit with us",
  ]
  size = quotes.length
  quotes[randomInt(size)]

quoteToShow = (number) ->
  switch number
    when 2 then "That's not a thing."
    when 4 then "That's so fetch!"
    when 8 then "Get in loser, we're going shopping."
    when 16 then "She doesn't even go here!"
    when 32 then "We wear pink on Wednesdays."
    when 64 then "That's why her hair is so big; it's full of secrets."
    when 128 then "One time, she punched me in the face. It was awesome."
    when 256 then "So you think you're really pretty."
    when 512 then "I hate my pores."
    when 1024 then "You girls keep me young."

getBiggestNumber = (board) ->
  biggestSeenSoFar = 0
  for row in board
    for value in row
      if value > biggestSeenSoFar
        biggestSeenSoFar = value
  biggestSeenSoFar

# changeBackground = (background) ->
#   switch background
#     when 2 then img src="http://www.imgbase.info/images/safe-wallpapers/tv_movies/mean_girls/3156-tv_movies_mean_girls_wallpaper.jpg")
#     when 4 then "That's so fetch!"
#     when 8 then "Get in loser, we're going shopping."
#     when 16 then "She doesn't even go here!"
#     when 32 then "We wear pink on Wednesdays."
#     when 64 then "That's why her hair is so big; it's full of secrets."
#     when 128 then "One time, she punched me in the face. It was awesome."
#     when 256 then "So you think you're really pretty."
#     when 512 then "I hate my pores."
#     when 1024 then "You girls keep me young."



$ ->

  $('.board').hide()
  $('.board').fadeIn(5000)

  @board = buildBoard()
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  biggestNumber = getBiggestNumber(@board)
  showBoard(@board)

  $('#restart_game').click(restartGame)


  $('body').keydown (e) =>

    key = e.which
    keys = [37..40]

    if key in keys
      e.preventDefault()
      # continue the game
      # console.log "key: ", key
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
        # myQuote = randomQuote() #need to store result of function to show later
        # $("#random_quote").html("#{myQuote}")

        #biggestNumberOnBoard = getBiggestNumber(@board)
        #console.log "biggest number is: " + biggestNumberOnBoard
        $("#random_quote").html(quoteToShow(getBiggestNumber(@board)))
        # $("#background-image").css(changeBackground(getBiggestNumber(@board)))


        if isGameOver(@board)
          console.log "Game over!!"
        else
          # show board
          showBoard(@board)
      else
        console.log "invalid"
    else
      # do nothing

