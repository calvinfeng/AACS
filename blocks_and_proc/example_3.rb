def many_procs_one_block(prc1, prc2, prc3, &block)
    prc1.call
    prc2.call
    prc3.call
    yield
end

many_procs_one_block(
    Proc.new{ puts "Hello I'm one" },
    Proc.new{ puts "Hello I'm two" },
    Proc.new{ puts "Hello I'm three" }
) do
    puts "Hello I am a block!"
end
