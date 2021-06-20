require_relative 'doublylinkedlist'
require_relative 'hashmap'
require 'byebug'

class LruCache
    attr_accessor :hash,:list,:size
    def initialize(size = 5)
        @hash = MyHashMap.new
        @list = DoublyLinkedList.new
        @size = size
    end

    def eject
        link = @list.delete_first
        key = link.value[0]
        @hash.delete(key)
        link
    end

    def read(key)
        link = @hash[key]
        return link.value[1] unless link.nil?
        nil
    end

    def display 
        @list.print_list
    end

    def insert(key,value)
        if @hash.has_key?(key)
            link = @hash[key]
            tail = @list.tail == link
            head = @list.head == link
            if !tail && !head
                n ,prev = link.next_ptr ,link.prev_ptr   
                n.prev_ptr = prev
                prev.next_ptr = n 
                link = @list.add_last([key,value])
                hash[key] = link
            elsif !tail && head
                @list.delete_first
                link = @list.add_last([key,value])
                hash[key] = link
            elsif
                link.value = [key,value]
            end
        else  
            eject if full?  
            link = @list.add_last([key,value])
            hash[key] = link
        end
        link
    end

    def full?
        @hash.number_of_items == @size
    end
end