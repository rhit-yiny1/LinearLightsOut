import 'dart:math';

import 'package:test/test.dart';

enum LightsStatus {
  on,
  off,
}

enum GameStatus {
  ongoing,
  ingame,
  ended,
}

class LinearLightsOutGame {
  final board = List<LightsStatus>.filled(7, LightsStatus.on);
  var state = GameStatus.ongoing;
  var numMoves = 0;

  void pressedLight(int index) {
    if (board[index] == LightsStatus.off) {
      board[index] = LightsStatus.on;
    } else {
      board[index] = LightsStatus.off;
    }
    if (index == 0) {
      if (board[index + 1] == LightsStatus.off) {
        board[index + 1] = LightsStatus.on;
      } else {
        board[index + 1] = LightsStatus.off;
      }
    } else if (index == 6) {
      if (board[index - 1] == LightsStatus.off) {
        board[index - 1] = LightsStatus.on;
      } else {
        board[index - 1] = LightsStatus.off;
      }
    } else {
      if (board[index + 1] == LightsStatus.off) {
        board[index + 1] = LightsStatus.on;
      } else {
        board[index + 1] = LightsStatus.off;
      }
      if (board[index - 1] == LightsStatus.off) {
        board[index - 1] = LightsStatus.on;
      } else {
        board[index - 1] = LightsStatus.off;
      }
    }
    numMoves++;
    this.checkForWin();
  }

  void presetDetermine() {
    var randonInt = Random().nextInt(7);
    this.pressedLight(randonInt);
    randonInt = Random().nextInt(7);
    this.pressedLight(randonInt);
    randonInt = Random().nextInt(7);
    this.pressedLight(randonInt);
    this.numMoves = 0;
    this.state = GameStatus.ongoing;
  }

  void checkForWin() {
    var count = 0;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == LightsStatus.on) {
        count++;
      }
    }
    if (count != 0) {
      state = GameStatus.ingame;
    } else {
      state = GameStatus.ended;
    }
  }

  String get boardString {
    String boardStr = "";
    for (final bulbs in board) {
      if (bulbs == LightsStatus.on) {
        boardStr += "on ";
      } else {
        boardStr += "off ";
      }
    }
    return boardStr;
  }

  @override
  String toString() {
    return boardString;
  }
}

void main() {
  print("Linear Lights Out");
  //developmentWithPrintStatements();
  developmentWithUnitTesting();
}

//Test cases
void developmentWithUnitTesting() {
  var game = LinearLightsOutGame();
  setUp(() {
    game = LinearLightsOutGame();
  });

  test('Initial game board', () {
    expect(game.board.length, equals(7));
    expect(game.board[0], equals(LightsStatus.on));
  });

  test('Single Test pressed', () {
    game.pressedLight(0);
    expect(game.board[0], equals(LightsStatus.off));
    expect(game.board[1], equals(LightsStatus.off));
    game.pressedLight(6);
    expect(game.board[6], equals(LightsStatus.off));
    expect(game.board[5], equals(LightsStatus.off));
    game.pressedLight(3);
    expect(game.board[3], equals(LightsStatus.off));
    expect(game.board[2], equals(LightsStatus.off));
    expect(game.board[4], equals(LightsStatus.off));
    game.pressedLight(3);
    expect(game.board[3], equals(LightsStatus.on));
    expect(game.board[2], equals(LightsStatus.on));
    expect(game.board[4], equals(LightsStatus.on));
  });
}
