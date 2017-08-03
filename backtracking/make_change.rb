
# Example greedy_make_change(24, [10, 7, 1])
# Assuming coins are sorted
def greedy_make_change(value, coins)
    return [] if value == 0 || coins.empty?
    num_coin = value / coins.first
    remaining_value = value % coins.first
    [coins.first] * num_coin + greedy_make_change(remaining_value, coins.drop(1))
end

greedy_make_change(24, [10, 7, 1])

# Two solution
# 1. Uses the biggest coin
# 2. Doesn't use the biggest coin
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

# def make_change(target, coins = [25, 10, 5, 1])
#   # Don't need any coins to make 0 cents change
#   return [] if target == 0
#   # Can't make change if all the coins are too big. This is in case
#   # the coins are so weird that there isn't a 1 cent piece.
#   return nil if coins.none? { |coin| coin <= target }
#
#   # Optimization: make sure coins are always sorted descending in
#   # size. We'll see why later.
#   coins = coins.sort.reverse
#
#   best_change = nil
#   coins.each_with_index do |coin, index|
#     # can't use this coin, it's too big
#     next if coin > target
#
#     # use this coin
#     remainder = target - coin
#
#     # Find the best way to make change with the remainder (recursive
#     # call). Why `coins.drop(index)`? This is an optimization. Because
#     # we want to avoid double counting; imagine two ways to make
#     # change for 6 cents:
#     #   (1) first use a nickel, then a penny
#     #   (2) first use a penny, then a nickel
#     # To avoid double counting, we should require that we use *larger
#     # coins first*. This is what `coins.drop(index)` enforces; if we
#     # use a smaller coin, we can never go back to using larger coins
#     # later.
#     best_remainder = make_change(remainder, coins.drop(index))
#
#     # We may not be able to make the remaining amount of change (e.g.,
#     # if coins doesn't have a 1cent piece), in which case we shouldn't
#     # use this coin.
#     next if best_remainder.nil?
#
#     # Otherwise, the best way to make the change **using this coin**,
#     # is the best way to make the remainder, plus this one coin.
#     this_change = [coin] + best_remainder
#
#     # Is this better than anything we've seen so far?
#     if (best_change.nil? || (this_change.count < best_change.count))
#       best_change = this_change
#     end
#   end
#
#   best_change
# end

p make_change(24, [10, 7, 1])
# [[5], [1], [3,4], [4]].min_by { |el| el.length}
