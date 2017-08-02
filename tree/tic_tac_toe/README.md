# Tic Tac Toe
Please look at `game_state_tree.rb` and see how I use breadth-first traversal and depth-first traversal to collect all the
possible end states of a Tic Tac Toe game.

## GameState
We treat game state as a tree node; it contains two key pieces of information, i.e. state of the board and current mark.

```ruby
# GameState
def initialize(board, current_mark)
    @board = board
    @current_mark = current_mark
end
```

## GameStateTree
We construct a tree using `GameState` as our tree nodes. We begin with a root:
```ruby
# GameStateTree
def initialize(board=Board.new)
    @root_state = GameState.new(board, :X)
end
```

#### Using Breadth-first
From the root, we can begin to construct a tree by playing out all the possible moves the root state can do, assuming that
we begin with an empty board and `:X` as our first player.
```
Root State

_ | _ | _
_ | _ | _
_ | _ | _
```

We add this state into a queue and proceed with the following logic:
``` ruby
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
```

For a given state, we ask how many possible children it can spawn. E.g. the root state can spawn 9 children:
```
x | _ | _        _ | x | _        _ | _ | x
_ | _ | _        _ | _ | _        _ | _ | _
_ | _ | _        _ | _ | _        _ | _ | _
```
```
_ | _ | _        _ | _ | _        _ | _ | _
x | _ | _        _ | x | _        _ | _ | x
_ | _ | _        _ | _ | _        _ | _ | _
```
```
_ | _ | _        _ | _ | _        _ | _ | _
_ | _ | _        _ | _ | _        _ | _ | _
x | _ | _        _ | x | _        _ | _ | x
```

We then append each of these child states to the queue and go on to search for our `end_states`

#### Using Depth-first
Instead of a queue, we simply use recursion and the implementation looks strikingly similar to that of breadth-first

``` ruby
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
```
