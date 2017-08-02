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

take_block do
    puts "Just a random func"
end
