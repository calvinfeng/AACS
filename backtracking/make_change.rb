
# Example greedy_make_change(24, [10, 7, 1])
# Assuming coins are sorted
def greedy_make_change(value, coins)
    return [] if value == 0 || coins.empty?
    num_coin = value / coins.first
    remaining_value = value % coins.first
    [coins.first] * num_coin + greedy_make_change(remaining_value, coins.drop(1))
end

p greedy_make_change(24, [10, 7, 1])

def recursive_make_change(value, coins)
    return [] if value == 0 || coins.empty?
    changes = []
    coins.each_index do |i|
        next if coins[i] > value
        remaining_value = value - coins[i]
        coin_change = [coins[i]] + recursive_make_change(remaining_value, coins.drop(i))
        changes << coin_change
    end
    changes.min_by { |change| change.length }
end

p recursive_make_change(24, [10, 7, 1])


def iterative_make_change(value, coins)
    return [] if value == 0 || coins.empty?
    changes = []
    stack = [[value, coins, []]]
    until stack.empty?
        value, coins, current_change = stack.pop
        if value == 0
            changes << current_change
        else
            coins.each_index do |i|
                next if coins[i] > value
                remaining_value = value - coins[i]
                updated_change = current_change.dup
                updated_change << coins[i]
                stack << [remaining_value, coins.drop(i), updated_change]
            end
        end
    end
    changes.min_by { |change| change.length }
end

p iterative_make_change(24, [10, 7, 1])
