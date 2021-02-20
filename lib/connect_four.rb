# frozen_string_literal: true

require 'pry'
require 'pp'

class Board
  attr_accessor :board

  def initialize(height = 6, width = 7)
    @height = height
    @width = width
    @board = generate_board(height, width)
    # @direction = { W: [0, -1], E: [0, 1], S: [1, 0], N: [-1, 0], NW: [-1, -1], NE: [-1, 1], SW: [1, -1], SE: [1, 1] }
    @direction = { E: [0, 1], N: [-1, 0], NW: [-1, -1], NE: [-1, 1] }
  end

  def generate_board(height, width)
    Array.new(height) { Array.new(width) }
  end

  def in_bounds?(pos_row, pos_col)
    (pos_row >= 0 && pos_row < @height) && (pos_col >= 0 && pos_col < @width)
  end

  # takes start coordinates, and direction to check. returns color when 4 in a row are found
  def check_neighbours(row, col, direction, color = nil, count = 1)
    d_row = @direction[direction][0]
    d_col = @direction[direction][1]
    return nil unless in_bounds?(row + d_row, col + d_col)

    color = @board[row][col] if color.nil?
    return nil unless @board[row + d_row][col + d_col] == color

    count += 1
    return color if count == 4

    check_neighbours(row + d_row, col + d_col, direction, color, count)
  end

  # can be optimized. @direction is defining every direction twice. S = N W = E NW = SE etc.
  def winner?
    token = nil
    @height.times do |row|
      @width.times do |col|
        @direction.each_key { |key| token = check_neighbours(row, col, key) if check_neighbours(row, col, key) }
        return token if token
      end
    end
    token
  end

  def column_full?(col)
    !@board[0][col].nil?
  end

  def column_exist?(col)
    col <= @board[0].length - 1 && col >= 0
  end

  # expects token and colunm, adds token to lowest (highest value) empty spot in column.
  def add_token(token, col, row = 0)
    return nil unless column_exist?(col)
    return nil if column_full?(col)

    if row < @board.length - 1 && @board[row + 1][col].nil?
      add_token(token, col, row + 1)
    else
      @board[row][col] = token
    end
  end

  def print_board
    pp @board
  end
end

class Player
  attr_reader :token, :name

  def initialize(name, token)
    @name = name
    @token = token
  end

  def choose_column
    puts "Hey #{@name}, In which column do you want to drop your token?"
    gets.chomp.to_i
  end
end

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new('Johan', 'X')
    @player2 = Player.new('Marijke', 'O')
  end

  def start_game
    puts 'Welcome to Connect-4!'
    loop do
      @board.print_board
      @board.add_token(@player1.token, @player1.choose_column)
      if @board.winner?
        declare_winner(@player1)
        break
      end

      @board.print_board
      @board.add_token(@player2.token, @player2.choose_column)
      if @board.winner?
        declare_winner(@player2)
        break
      end
    end
  end

  def declare_winner(player)
    puts "#{player.name} is the winner! Good for you!"
  end
end

game = Game.new
game.start_game
