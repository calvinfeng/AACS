def perms(digits)
    return (0..9).map {|radix| [radix]} if digits == 1
    result = []
    (0..9).each do |radix|
        sub_perms = perms(digits - 1)
        result += sub_perms.map do |arr|
            arr << radix
        end
    end
    result
end

class Array
    def my_flatten
        result = []
        (0..self.length - 1).each do |idx|
            if self[idx].class != Array
                result << self[idx]
            else
                result += self[idx].my_flatten
            end
        end
        result
    end
end
