def test_tic_tac_toe
  player1 = Player.new("Player 1", "X")
  player2 = Player.new("Player 2", "O")

  # Test player 1 winning horizontally
  game = Game.new
  game.board[0] = ["X", "X", "X"]
  assert_equal("Player 1 wins!", game.play)

  # Test player 2 winning vertically
  game = Game.new
  game.board[0][0] = "O"
  game.board[1][0] = "O"
  game.board[2][0] = "O"
  assert_equal("Player 2 wins!", game.play)

  # Test player 1 winning diagonally
  game = Game.new
  game.board[0][0] = "X"
  game.board[1][1] = "X"
  game.board[2][2] = "X"
  assert_equal("Player 1 wins!", game.play)

  # Test a tie game
  game = Game.new
  game.board[0][0] = "X"
  game.board[0][1] = "O"
  game.board[0][2] = "X"
  game.board[1][0] = "O"
  game.board[1][1] = "X"
  game.board[1][2] = "O"
  game.board[2][0] = "X"
  game.board[2][1] = "O"
  game.board[2][2] = "X"
  assert_equal("It's a tie!", game.play)

  # Test an incomplete game
  game = Game.new
  game.board[0][0] = "X"
  game.board[0][1] = "O"
  game.board[0][2] = "X"
  game.board[1][0] = "O"
  game.board[1][1] = "X"
  game.board[2][0] = "X"
  assert_equal(nil, game.play)
end
