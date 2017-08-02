class PathNode
    @attr_reader :neighbors, :cost, :from
    def initialize(i, j)
        @row = i
        @col = j
        @from = nil
        @neighbors = []
        @cost = 1
    end

    def to_s
        "(#{@row}, #{@col})"
    end

    def set_from_node(node)
        @from = node
    end
end
