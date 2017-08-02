def move_tower(height, source, dest, spare)
    if height == 1
        puts "Move disk #{height} from tower #{source} to tower #{dest}"
    else
        move_tower(height - 1, source, spare, dest)
        puts "Move disk #{height} from tower #{source} to tower #{dest}"
        move_tower(height - 1, spare, dest, source)
    end
end

move_tower(5, "A", "C", "B")

def iterative_move_tower(height)
    height % 2 == 0 ? dir = 1 : dir = -1
    towers = [[], [], []]
    i = 0
    while i < height
        towers[0] << height - i
        i += 1
    end

    # minTower will point to tower with smallest disk
    min_tower = 0

    # We need 2^height - 1 moves
    num_of_moves = (1 << height) - 1;

    next_move = [1, 2, 0]
    prev_move = [2, 0, 1]

    moves = []
    move_smallest = true
    i = 0
    while i < num_of_moves
        if (move_smallest)
            old_min_tower = min_tower
            min_tower = (old_min_tower + dir + 3) % 3
            puts "Move disk from #{old_min_tower} to #{min_tower}"
        else
            if top_disk_size(next_move[min_tower], towers) > top_disk_size(prev_move[min_tower], towers)
                puts "Move disk from #{prev_move[min_tower]} to #{next_move[min_tower]}"
            else
                puts "Move disk from #{next_move[min_tower]} to #{prev_move[min_tower]}"
            end
        end
        move_smallest = !move_smallest
        i += 1
    end
end

def top_disk_size(tower_index, towers)
    return 99999999 if towers[tower_index].length == 0
    tower = towers[tower_index]
    tower.last
end

iterative_move_tower(3)
