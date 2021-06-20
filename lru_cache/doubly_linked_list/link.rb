

class Link
    attr_accessor :value ,:next_ptr,:prev_ptr
    def initialize(value,prev = nil,n = nil)
        @value = value
        @next_ptr = n
        @prev_ptr = prev
    end
end