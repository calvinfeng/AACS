require_relative 'board'

# We will move from left to right, column by column
def seek_solution(board)
    return board if board.is_solved?
    col = board.queen_count
    (0...board.size).each do |row|
        if board.is_pos_valid?(row, col)
            new_board = board.dup
            new_board.place_queen(row, col)
            solution = seek_solution(new_board)
            return solution if solution
        end
    end
    false
end

my_board = Board.new(4)
solution = seek_solution(my_board)
puts solution
