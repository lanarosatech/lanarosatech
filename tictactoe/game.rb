class Board
  def initialize
    # Initialize the board with an empty 2D array
    @board = Array.new(3) { Array.new(3) }
  end

  def display
    # Print the current state of the board
    @board.each do |row|
      puts row.join(" | ")
      puts "---------\n"
    end
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Level
  attr_reader :name, :difficulty

  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
  end
end

class Game
  def initialize(computer_vs_computer)
    @board = Board.new
    @player1 = Player.new("Player 1", "X")
    @player2 = Player.new("Player 2", "O")
    @current_player = @player1
    @levels = [
      Level.new("Easy", 1),
      Level.new("Medium", 2),
      Level.new("Hard", 3)
    ]
    @current_level = @levels[0]
    @computer_vs_computer = computer_vs_computer
    @player1_vs_computer = player1_vs_computer
  end

  def set_level(level)
    @current_level = level
  end

  def display_level
    puts "Current level: #{@current_level.name}"
  end

  def play
    # Main game loop
    loop do
      # Prompt the current player for their move
      if @current_player == @player1 && !@computer_vs_computer
        puts "It's #{@current_player.name}'s turn. Enter a row and column (e.g. 0 1):"
        row, col = gets.chomp.split.map(&:to_i)
      elsif @current_player == @player1 && !@player1_vs_computer
        puts "It's #{@current_player.name}'s turn. Enter a row and column (e.g. 0 1):"
        row, col = gets.chomp.split.map(&:to_i)
      else
        # Choose a move for the computer player
        row, col = choose_move(@current_player)
      end

      # Update the board with the player's move
      @board[row][col] = @current_player.symbol

      # Display the updated board
      @board.display

      # Check who won or if the game is over/tied
      if game_over?
        if game_over? == "X"
          puts "#{@player1.name} wins!"
        elsif game_over? == "O"
          puts "#{@player2.name} wins!"
        else
          puts "It's a tie!"
        end
        break
      end

      # Switch to the other player
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end
  end

  def check_game
    # Check rows, columns, and diagonals for blocking moves
    (0..2).each do |i|
      # Check rows
      if @board[i][0] == other_player_symbol && @board[i][1] == other_player_symbol && @board[i][2].nil?
        return [i, 2]
      elsif @board[i][0] == other_player_symbol && @board[i][1].nil? && @board[i][2] == other_player_symbol
        return [i, 1]
      elsif @board[i][0].nil? && @board[i][1] == other_player_symbol && @board[i][2] == other_player_symbol
        return [i, 0]

      # Check columns
      elsif @board[0][i] == other_player_symbol && @board[1][i] == other_player_symbol && @board[2][i].nil?
        return [2, i]
      elsif @board[0][i] == other_player_symbol && @board[1][i].nil? && @board[2][i] == other_player_symbol
        return [1, i]
      elsif @board[0][i].nil? && @board[1][i] == other_player_symbol && @board[2][i] == other_player_symbol
        return [0, i]

      # Check diagonals
      if @board[0][0] == other_player_symbol && @board[1][1] == other_player_symbol && @board[2][2].nil?
        return [2, 2]
      elsif @board[0][0] == other_player_symbol && @board[1][1].nil? && @board[2][2] == other_player_symbol
        return [1, 1]
      elsif @board[0][0].nil? && @board[1][1] == other_player_symbol && @board[2][2] == other_player_symbol
        return [0, 0]

      elsif @board[0][2] == other_player_symbol && @board[1][1] == other_player_symbol && @board[2][0].nil?
        return [2, 0]
      elsif @board[0][2] == other_player_symbol && @board[1][1].nil? && @board[2][0] == other_player_symbol
        return [1, 1]
      elsif @board[0][2].nil? && @board[1][1] == other_player_symbol && @board[2][0] == other_player_symbol
        return [0, 2]
      end
    end
  end

  def choose_move(player)
    # Find the symbol of the other player
    other_player_symbol = (player.symbol == "X") ? "O" : "X"

      case @current_level.difficulty
      when 1
        # Choose a random empty position on the board
        # If no blocking moves are found, choose a random empty position
        check_game
        empty_positions = []
        # Find all empty positions on the board
        @board.each_with_index do |row, i|
          row.each_with_index do |cell, j|
            empty_positions << [i, j] if cell.nil?
          end
        end
        return empty_positions.sample
      when 2
        check_game
        # Try to block the other player from getting three in a row
      when 3
        check_game
        # Try to optimize the player's moves to win the game
      end
    end

  def game_over?
    # Check the rows
    @board.each do |row|
      return true if row.all? { |cell| cell == "X" }
      return true if row.all? { |cell| cell == "O" }
    end

    # Check the columns
    (0..2).each do |col|
      return true if @board.all? { |row| row[col] == "X" }
      return true if @board.all? { |row| row[col] == "O" }
    end

    # Check the diagonals
    return true if @board.all? { |i| @board[i][i] == "X" }
    return true if @board.all? { |i| @board[i][i] == "O" }
    return true if @board.all? { |i| @board[i][2 - i] == "X" }
    return true if @board.all? { |i| @board[i][2 - i] == "O" }

    # Check if the board is full
    @board.none? { |row| row.include?("") }
  end

end

# Start the game
game = Game.new
game.play
