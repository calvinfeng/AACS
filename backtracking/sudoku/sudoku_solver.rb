################
# Sudoku Solver
################
require_relative 'board'

# Few helper methods
def seek_empty_cell(board)
    board.rows.each_index do |i|
        board.rows[i].each_index do |j|
            pos = [i, j]
            return pos if board[pos].value == 0
        end
    end
end


# Using Depth-first approach
def seek_solution(board) # => either return a solved_board or false
    return board if board.solved?
    row_idx, col_idx = seek_empty_cell(board)
    square_idx = row_idx / 3 * 3 + col_idx / 3
    (1..9).each do |digit|
        unless board.rows[row_idx].map(&:value).include?(digit) ||
            board.columns[col_idx].map(&:value).include?(digit) ||
            board.square(square_idx).map(&:value).include?(digit)
        new_board = board.dup
        new_board[[row_idx, col_idx]] = digit
        solution = seek_solution(new_board)
        return solution if solution
        end
    end
    return false
end


my_board = Board.from_file('./puzzles/hard.txt')
my_board.render
solution = seek_solution(my_board)
solution.render
