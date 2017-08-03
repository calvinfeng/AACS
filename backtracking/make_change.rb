
# Example greedy_make_change(24, [10, 7, 1])
# Assuming coins are sorted
def greedy_make_change(value, coins)
    return [] if value == 0 || coins.empty?
    num_coin = value / coins.first
    remaining_value = value % coins.first
    [coins.first] * num_coin + greedy_make_change(remaining_value, coins.drop(1))
end

greedy_make_change(24, [10, 7, 1])

def make_change(value, coins)
    return [] if value == 0 || coins.empty?
    results = []
    coins.each_index do |i|
        next if coins[i] > value
        remaining_value = value - coins[i]
        result = [coins[i]] + make_change(remaining_value, coins.drop(i))
        results << result
    end
    results.min_by { |result| result.length }
end

p make_change(24, [10, 7, 1])
