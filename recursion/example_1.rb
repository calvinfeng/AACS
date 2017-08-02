def print_nums(n)
    puts n
    print_nums(n - 1) unless n == 1
end

print_nums(10)

def factorial(n)
    return 1 if n <= 1
    n * factorial(n - 1)
end

p factorial(5)

def fib_num(n)
    return 1 if n == 1 || n == 2
    fib_num(n - 1) + fib_num(n - 2)
end

p fib_num(5)
