require_relative './board.rb'

class GameState
    attr_reader :board, :current_mark
    def initialize(board, current_mark)
        @board = board
        @current_mark = current_mark
    end

    def end?
        @board.over?
    end
end

class GameStateTree
    def initialize(board=Board.new)
        @root_state = GameState.new(board, :X)
    end

    def bfs_end_states
        queue = [@root_state]
        result = Hash.new
        until queue.empty?
            current_state = queue.shift
            if current_state.end?
                result[current_state.board.to_s] = current_state
            else
                mark = current_state.current_mark
                current_state.board.available_moves.each do |move|
                    new_board = current_state.board.get_copy
                    new_board.place_mark(move, mark)
                    if mark == :X
                        new_state = GameState.new(new_board, :O)
                    else
                        new_state = GameState.new(new_board, :X)
                    end
                    queue << new_state
                end
            end
        end
        result
    end


    def dfs_end_states
        find_end_states(@root_state)
    end

    def find_end_states(current_state)
        result = Hash.new
        if current_state.end?
            result[current_state.board.to_s] = current_state
            return result
        end
        mark = current_state.current_mark
        current_state.board.available_moves.each do |move|
            new_board = current_state.board.get_copy
            new_board.place_mark(move, mark)
            if mark == :X
                new_state = GameState.new(new_board, :O)
            else
                new_state = GameState.new(new_board, :X)
            end

            sub_result = find_end_states(new_state)
            result = result.merge(sub_result)
        end
        result
    end
end



my_tree = GameStateTree.new

total_end_states = my_tree.dfs_end_states

total_end_states.each do |state_str, state|
    puts state.board.to_s
    puts "------"
end

puts "Total number of end state of a Tic Tac Toe game is #{total_end_states.length}"
