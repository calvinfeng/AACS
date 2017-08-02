class Board
    def initialize(size=8)
        @size = size
        @queen_positions = []
        @grid = Array.new(size) { Array.new(size) }
    end

    def size
        @size
    end

    def rows
        @grid
    end

    def columns
        @grid.transpose
    end

    def is_solved?
        queen_count == @size
    end

    def queen_count
        @queen_positions.length
    end

    def place_queen(i, j)
        if is_pos_valid?(i, j)
            @grid[i][j] = 1
            @queen_positions << [i, j]
        else
            raise "Cannot make that move"
        end
    end

    def is_pos_valid?(i, j)
        # Moving diagonally toward top-left
        row, col = i, j
        until row < 0 || col < 0
            return false unless @grid[row][col].nil?
            row -= 1
            col -= 1
        end

        # Moving diagonally toward bottom-right
        row, col = i, j
        until row == @size || col == @size
            return false unless @grid[row][col].nil?
            row += 1
            col += 1
        end

        # Moving diagonally toward top-right
        row, col = i, j
        until row < 0 || col == @size
            return false unless @grid[row][col].nil?
            row -= 1
            col += 1
        end

        # Moving diagonally toward bottom-left
        row, col = i, j
        until row == @size || col < 0
            return false unless @grid[row][col].nil?
            row += 1
            col -= 1
        end

        rows[i].all? { |el| el.nil? } && columns[j].all? { |el| el.nil? }
    end

    def render
        puts self
    end

    def dup
        new_board = Board.new(@size)
        @queen_positions.each do |pos|
            i, j = pos
            new_board.place_queen(i, j)
        end
        new_board
    end

    def to_s
        @grid.map do | row |
            row.map do | el |
                el.nil? ? " _ " : " Q "
            end.join
        end.join("\n")
    end
end
