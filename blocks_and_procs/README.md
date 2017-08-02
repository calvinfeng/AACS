# Blocks and Procs
In Ruby, you can define a function but you cannot treat a function as a variable. Perhaps this idea seems foreign to you; in many functional languages (e.g JavaScript), functions are treated as variables, which means you can pass a function into another function as an argument. Ruby does not allow you to pass a function around as variable because Ruby was not intended to be a functional language.

However, in the later releases, Ruby became a *multi-paradigm language* by introducing `block` and `proc`.

## Blocks
### They are functions
A Ruby block is nothing more than a snippet of code; the best way to put it, block is a function. It takes an argument and does something to the argument.

```ruby
[1, 2, 3, 4, 5].each do |num|
    puts num * num
end
```

## Procs
### They are objects
When you convert a block into a proc, you can easily pass it around just like any other variables. Think of proc as a plastic wrapper around a sandwich you bring to work everyday. I am pretty sure that you won't just stuff a raw sandwich into your backpack and carry it around.

```ruby
def take_block(&prc)
    yield
    need_proc(prc)
end

def need_proc(prc)
    prc.call
    need_proc_too(prc)
end

def need_proc_too(prc)
    prc.call
end
```

As you can see, I can pass a block into `take_block` and then propagate it forward to `need_proc` and `need_proc_too`. It can go on forever, as deep as you want it to be.

## Ampersand &
Let's talk about & first. When you see a function with *ampersanded* arguments, it is expecting a block.

Ampersand converts a block into a proc and store it as `code_snippet` in this example.
```ruby
ruby
def func(&code_snippet)
    # Expects a block
end
```

Since code_snippet has become a proc, we need to use & on it to convert it back to a block
```ruby
# Passing as block
call_block(&code_snippet)
```

Now if you have a function that takes a proc, calling `yield` on it will give you an error
```ruby
# function takes a proc and calling yield will give an error
def call_proc(prc)
    yield
    prc.call("Hello from a proc call")
end
```

## Many Procs
### One block
Every function can take only one block but it can take many procs
```ruby
def many_procs_one_block(prc1, prc2, prc3, &block)
    prc1.call
    prc2.call
    prc3.call
    yield
end
```

### Pass them on
You can accumulate blocks and call them all at once
```ruby
def level_1(&prc1)
    level_2(prc1) do
        puts "Block 2"
    end
end

def level_2(prc1, &prc2)
    level_3(prc1, prc2) do
        puts "Block 3"
    end
end

def level_3(prc1, prc2, &prc3)
    prc1.call
    prc2.call
    prc3.call
end

level_1 do
    puts "Block 1"
end
```
