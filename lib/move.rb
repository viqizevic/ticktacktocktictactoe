
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

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # First diagonal
  [2,4,6]  # Second diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3
    if position_1 == position_2 && position_2 == position_3 && (position_1 == "X" || position_1 == "O")
      return win_combination # return the win_combination indexes that won.
    end
  end
  false
end

def full?(board)
  board.all? { |e| e == "X" || e == "O" }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  win_combination = won?(board)
  win_combination ? board[win_combination[0]] : nil
end
