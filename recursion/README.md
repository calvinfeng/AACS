# Recursion
Thinking recursively is closely tied to one's ability to break down a bigger problem into smaller chunks. Recursion is a particularly powerful kind of problem reduction, which can be described loosely as follows:

* If given instance of the problem is small or simple enough, just solve it

* Otherwise, reduce the problem to one or more simpler instances of the same problem

We generally call the first statement a *base case* of our recursive algorithm and the second statement as the *recursive step* or *reduction step*.

## Bad Examples
A lot of text books or courses tend to teach factorial and Fibonacci sequence as the introduction to recursion. Yes they are easy to write and demonstrate to students that what recursion means. However, from a computational efficiency perspective, they are actually the examples of when you should *NOT* use recursion.

Let's take a look at

### Print numbers
Suppose we are given a task to print a range of numbers, from n to 1. The iterative solution is the one we are most familiar with.

```ruby
def print_nums(n)
    until n == 0
        puts n
        n -= 1
    end
end
```

Here's the recursive version
```ruby
def print_nums(n)
    puts n
    print_nums(n - 1) unless n == 1
end
```

The base case is do nothing while the recursive step is to print a number and call `print_nums` again

### Factorial
Factorial is the simplest of all recursion examples. It's good for introducing a concept but it does not give good motivation of using recursion. Just keep in mind, this example is only there to show you what recursion is, but not why recursion is needed.

```ruby
def factorial(n)
    return 1 if n <= 1
    n * factorial(n - 1)
end
```

### Fibonacci number
Fibonacci number is another favorite one by many computer science educator. And, again this is actually extremely inefficient as compared to the iterative version.

```ruby
# Write a function to generate the nth Fibonacci number
def fib_num(n)
    return 1 if n == 1 || n == 2
    fib_num(n - 1) + fib_num(n - 2)
end
```

## Good Examples
Recursion should help you with solving complicate problem that is otherwise hard to solve with pure iterative approach.
Tower of Hanoi would be a classic example

### Tower of Hanoi

#### 2 Disks
```
  o
 ooo
===== ===== =====
  A     B     C
```
In order to move the tower from A to C, we first need to move the the top tower of 1 disk from A to B. Let's designate A as the *source*, B as the *spare* and C as the *destination*.

```
 ooo    o
===== ===== =====
```
And then we move the disk from source to destination.

```
        o    ooo
===== ===== =====
```
Finally, we can move the tower of one disk from spare to destination and complete our puzzle

#### 3 Disks
Three disks are that much different from two disks

```
  o
 ooo
ooooo
===== ===== =====
  A     B     C
```

In order to move the tower of 3 disks from A to C, we need to first move the top tower of 2 disks from A to B.

```
        o
ooooo  ooo
===== ===== =====
  A     B     C
```

Then we can proceed to move the big disk from A to C

```
        o
       ooo  ooooo
===== ===== =====
  A     B     C
```

Finally, we just need to move the tower of 2 disks from B to C and complete the puzzle

#### Implementation
```ruby
def move_tower(height, source, dest, spare)
    if height == 1
        puts "Move disk #{height} from pillar #{source} to pillar #{dest}"
    else
        move_tower(height - 1, source, spare, dest)
        puts "Move disk #{height} from pillar #{source} to pillar #{dest}"
        move_tower(height - 1, spare, dest, source)
    end
end

move_tower(3, "A", "B", "C")
```

Now let's take a look at the iterative approach to the same problem
```ruby
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
```

### My Flatten
Flatten a nested structure into a flat structure, e.g. array, hashes, or tree and graphs (that's for later)

Example
```ruby
[1, 2, 3, [4, [5, 6]], [[[7]]], 8].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
```

### Permutations
Given number of digits, generate all the possible permutation of these numeric digits

For example, if you were given 2 digits, you can generate 100 different permutations of the 2 digits.
```ruby
perms(2) => [[0, 0], [0, 1], [0, 2], [0, 3], ..., [9, 9]]
```
