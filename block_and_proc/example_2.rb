# func_one takes a block and convert it into a proc, which then you can pass it
# on to next function call
def func(&code_snippet) # <= Expects a block
    yield("Hello from a function call")
    # Passing as proc
    call_proc(code_snippet)
    # Passing as block
    call_block(&code_snippet)
end

# function takes a proc and calling yield will give an error
def call_proc(prc)
    prc.call("Hello from a proc call")
end

# function can take block implicitly
def call_block
    if block_given?
        yield("Hello from a block call")
    else
        puts "No block is given"
    end
end

func do |var|
    puts var
end
