
def display_board(board)
  3.times do |i|
    j = i * 3
    puts " #{board[j]} | #{board[j+1]} | #{board[j+2]} "
    if i < 2
      puts "-----------"
    end
  end
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, player="X")
  board[index] = player
end

def position_taken?(board, index)
  cell = board[index]
  cell != " " && cell != "" && cell != nil
end

def valid_move?(board, index)
  if not index.between?(0, board.length-1)
    return false
  end
  not position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  current_turn = 1
  while current_turn <= 9
    turn(board)
    current_turn += 1
  end
end

def turn_count(board)
  counter = 0
  board.each do |item|
    counter += (" " == item) ? 0 : 1
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
