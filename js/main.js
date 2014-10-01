// Generated by CoffeeScript 1.8.0
(function() {
  var buildBoard, generateTile, printArray, randomCellIndices, randomInt, randomValue;

  randomInt = function(x) {
    return Math.floor(Math.random() * x);
  };

  buildBoard = function() {
    return [0, 1, 2, 3].map(function() {
      return [0, 1, 2, 3].map(function() {
        return 0;
      });
    });
  };

  randomCellIndices = function() {
    return [randomInt(4), randomInt(4)];
  };

  randomValue = function() {
    var values;
    values = [2, 2, 2, 4];
    return values[randomInt(4)];
  };

  generateTile = function(board) {
    var column, row, value, _ref;
    value = randomValue();
    _ref = randomCellIndices(), row = _ref[0], column = _ref[1];
    console.log("row: " + row + " / col: " + column);
    if (board[row][column] === 0) {
      board[row][column] = value;
    } else {
      generateTile(board);
    }
    return console.log("generate tile");
  };

  printArray = function(array) {
    var row, _i, _len;
    console.log("-- Start --");
    for (_i = 0, _len = array.length; _i < _len; _i++) {
      row = array[_i];
      console.log(row);
    }
    return console.log("-- End --");
  };

  $(function() {
    var newBoard;
    newBoard = buildBoard();
    generateTile(newBoard);
    generateTile(newBoard);
    return printArray(newBoard);
  });

}).call(this);

//# sourceMappingURL=main.js.map
