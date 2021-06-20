require 'byebug'
require_relative 'link'
class DoublyLinkedList
    attr_reader :size,:head,:tail
    def initialize
        @head = nil
        @tail = nil
        @size = 0
    end

    def add_last(value)
        if empty?
            @head = Link.new(value)
            @tail = @head
        else  
            link = Link.new(value,@tail)
            @tail.next_ptr = link
            @tail = link
        end
        @size += 1
        @tail
    end

    def add_first(value)
        if empty?
            @head = Link.new(value)
            @tail = @head
        else  
            link = Link.new(value,nil,@head)
            @head.prev_ptr = link
            @head = link
        end
        @size += 1
        @head
    end

    def append_after(value,new_value)
        link = find_link(value)
        return nil if link.nil?
        n = link.next_ptr
        new_link = Link.new(new_value,link,n)
        link.next_ptr = new_link

        n.prev_ptr = new_link unless @tail == link
        @tail = new_link if @tail == link

        @size += 1
        new_link
    end


    def delete_first
        return nil if @size == 0
        if @size == 1
            link = @head
            @head,@tail,@size = nil,nil,0 
            return link
        end

        deleted = @head
        n = @head.next_ptr
        n.prev_ptr = nil 
        @head = n

        @size -= 1
        deleted
    end

    def delete_last
        return nil if @size == 0
        if @size == 1
            link = @tail
            @head,@tail,@size = nil,nil,0 
            return link
        end

        deleted = @tail
        prev = @tail.prev_ptr
        prev.next_ptr = nil 
        @tail = prev

        @size -= 1
        deleted
    end

    def delete(value)
        link = find_link(value)
        return nil if link.nil?

        prev = link.prev_ptr
        n = link.next_ptr

        prev.next_ptr = n unless @head == link
        n.prev_ptr = prev unless @tail == link

        @head = n if @head == link 
        @tail = prev if @tail == link

        @size -= 1
        link
    end

    

    def empty?
        @size == 0
    end

    def find_link(value)
        ptr = @head
        until ptr == nil || ptr.value == value
            ptr = ptr.next_ptr
        end
        ptr
    end

    def print_list
        ptr = @head
        list_str = ''
        until ptr == nil
            list_str += ptr.value.to_s + "->"
            ptr = ptr.next_ptr
        end
        puts list_str + "nil"
        nil
    end
end