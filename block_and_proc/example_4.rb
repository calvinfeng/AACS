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
