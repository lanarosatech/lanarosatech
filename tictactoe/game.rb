class Game
  # define the different levels of difficulty
  DIFFICULTIES = {
    easy: 1,
    medium: 2,
    hard: 3
  }

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = 'X' # the computer's marker
    @hum = 'O' # the user's marker
  end

  def start_game
    puts '# This is tic tac toe game #'
    puts 'Please select the opponent:'
    puts '1: Computer'
    puts '2: Another human player'
    input = gets.chomp

    # check if the input is a valid option
    if input.match(/\A[1-2]\z/)
      # convert the input to an integer
      opponent = input.to_i
    else
      opponent = nil
      puts 'Invalid input. Please enter a valid number.'
    end

    if opponent == 1
      # prompt the user to select the difficulty level
      puts 'Please select the difficulty level:'
      DIFFICULTIES.each do |name, value|
        puts "#{value}: #{name}"
      end
      difficulty = gets.chomp
      # check if the input is a valid difficulty level
      if difficulty.match(/\A[1-3]\z/)
        # convert the input to an integer and store it in the difficulty variable
        difficulty = difficulty.to_i
      else
        difficulty = nil
        puts 'Invalid difficulty level. Please enter a valid number.'
      end
    end

    current_player = 1
    loop do
      # print the game board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n===+===+===\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n===+===+===\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
      # get the current player's move
      if current_player == 1
        get_human_spot(1)
        # check if the game is over
        if game_is_over(@board)
          puts 'Player 1 wins!'
          break
        elsif tie(@board)
          puts 'Game is a tie!'
          break
        end
        current_player = 2
      else
        if opponent == 1
          # make the computer's move
          eval_board(difficulty)
          # check if the game is over
          if game_is_over(@board)
            puts 'Computer player wins!'
            break
          elsif tie(@board)
            puts 'Game is a tie!'
            break
          end
        else
          # get the second human player's move
          get_human_spot(2)
          # check if the game is over
          if game_is_over(@board)
            puts "Player 2 wins!"
            break
          elsif tie(@board)
            puts "Game is a tie!"
            break
          end

          # get the first human player's move
          get_human_spot(1)
          # check if the game is over
          if game_is_over(@board)
            puts "Player 1 wins!"
            break
          elsif tie(@board)
            puts "Game is a tie!"
            break
          end
        end
      end
    end
  end

  def get_human_spot(player)
    spot = nil
    until spot
      puts "Player #{player}, enter a number from 0 to 8:"
      input = gets.chomp
      # check if the input is a valid number in the range 0-8
      if input.match(/\A[0-8]\z/)
        # convert the input to an integer
        spot = input.to_i
        # check if the spot is available
        if @board[spot] != "X" && @board[spot] != "O"
          # set the board spot to the player's marker to indicate their move
          @board[spot] = player == 1 ? @hum : @com
        else
          spot = nil
        end
      end
    end
  end

  def eval_board(difficulty)
    spot = nil
    until spot
      case difficulty
      when DIFFICULTIES[:easy]
        # for the easy difficulty level, the computer player makes a random move
        spot = get_random_move
      when DIFFICULTIES[:medium]
        # for the medium difficulty level, the computer player makes the best possible move,
        # but prioritizing the center spot and the corners over the edges
        if @board[4] == "4"
          spot = 4
        else
          spot = get_best_corner_or_center_move(@board, @com)
        end
      when DIFFICULTIES[:hard]
        # for the hard difficulty level, the computer player makes the best possible move
        spot = get_best_move(@board, @com)
      end
      if @board[spot] != "X" && @board[spot] != "O"
        @board[spot] = @com
      else
        spot = nil
      end
    end
  end

  def get_random_move
    available_spaces = []
    @board.each_with_index do |marker, index|
      if marker != "X" && marker != "O"
        available_spaces << index
      end
    end
    # select a random space from the available spaces
    random_index = rand(0...available_spaces.count)
    return available_spaces[random_index]
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def get_best_corner_or_center_move(board, next_player)
    # first, check if the center spot is available
    if board[4] != "X" && board[4] != "O"
      return 4
    end
    # if the center spot is not available, check the corners
    corners = [0, 2, 6, 8]
    corners.each do |corner|
      if board[corner] != "X" && board[corner] != "O"
        return corner
      end
    end
    # if no corners are available, return a random edge spot
    edges = [1, 3, 5, 7]
    n = rand(0..edges.count)
    return edges[n]
  end

  def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end
end
game = Game.new
game.start_game
