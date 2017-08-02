class TreeNode
    attr_reader :value, :left_child, :right_child
    def initialize(val)
        @value = val
        @left_child = nil
        @right_child = nil
    end

    def full?
        !@left_child.nil? && !@right_child.nil?
    end

    def append_child(child)
        raise "Cannot take any more child" if full?
        if @left_child.nil?
            @left_child = child
        else
            @right_child = child
        end
    end

    def to_s
        "(#{@value})"
    end
end
