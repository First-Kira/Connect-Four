class ConnectFour
  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @current_player = 'X'
  end

  def print_board
    puts "  1   2   3   4   5   6   7"
    puts "+---+---+---+---+---+---+---+"
    @board.each do |row|
      puts "| #{row.join(' | ')} |"
      puts "+---+---+---+---+---+---+---+"
    end
  end

  def drop_piece(column)
    column_index = column - 1
    return false if column_index < 0 || column_index >= 7 || @board[0][column_index] != ' '

    row_index = 5
    while row_index >= 0
      if @board[row_index][column_index] == ' '
        @board[row_index][column_index] = @current_player
        return true
      end
      row_index -= 1
    end
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end

  def check_win
    # Check horizontally
    @board.each do |row|
      (0..3).each do |col|
        return true if row[col..col + 3].all? { |piece| piece == @current_player }
      end
    end

    # Check vertically
    (0..6).each do |col|
      (0..2).each do |row|
        return true if (0..3).all? { |i| @board[row + i][col] == @current_player }
      end
    end

    # Check diagonally (down-right)
    (0..2).each do |row|
      (0..3).each do |col|
        return true if (0..3).all? { |i| @board[row + i][col + i] == @current_player }
      end
    end

    # Check diagonally (up-right)
    (0..2).each do |row|
      (0..3).each do |col|
        return true if (0..3).all? { |i| @board[row + 3 - i][col + i] == @current_player }
      end
    end

    false
  end

  def play
    loop do
      print_board
      puts "Player #{@current_player}, enter a column (1-7) to drop your piece:"
      column = gets.chomp.to_i
      if drop_piece(column)
        if check_win
          print_board
          puts "Player #{@current_player} wins!"
          break
        elsif @board.flatten.all? { |piece| piece != ' ' }
          print_board
          puts "It's a draw!"
          break
        else
          switch_player
        end
      else
        puts "Invalid move. Please choose a valid column."
      end
    end
  end
end

game = ConnectFour.new
game.play

