class Array
    def my_each
        i = 0
        while i < self.length
            yield(self[i])
            i += 1
        end
        self
    end
end

class Hash
    def my_each
        self.keys.each do |key|
            yield(key, self[key])
        end
    end
end

{ a: 1, b: 2, c: 3 }.my_each do |key, value|
    puts "#{key}: #{value}"
end

[1, 2, 3, 4, 5].my_each do |num|
    puts num
end

class Array
    def my_map
        result = []
        i = 0
        while i < self.length
            result << yield(self[i])
            i += 1
        end
        result
    end
end

p [1, 2, 3, 4, 5].my_map { |num| num * num }

class Array
    def my_select
        result = []
        i = 0
        while i < self.length
            result << self[i] if yield(self[i])
            i += 1
        end
        result
    end
end

p [1, 2, 3, 4, 5].my_select { |num| num > 3 }
