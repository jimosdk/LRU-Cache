require_relative 'doublylinkedlist'
require 'byebug'

class MyHashMap
    attr_accessor :store,:size,:number_of_items
    def self.to_h(arr)
        h = MyHashMap.new
        h.redistribute(arr)
        h
    end

    def initialize 
        @store = []
        @size = 16 
        @number_of_items = 0
        @size.times{ @store << DoublyLinkedList.new}
    end

    def ==(hashmap)
        hashmap.to_a.all? do |k,v|
            self[k] == v
        end
    end

    def expand
        @size.times{@store << DoublyLinkedList.new}
        @size *= 2
    end

    def redistribute(arr)
        arr.each do |k,v|
            self[k] = v
        end
    end

    def extract_all_items
        @number_of_items = 0
        @store.each_with_object([]) do |dll,arr|
            arr << dll.delete_last.value until dll.empty?
        end
    end

    def hash_function(key)
        key.hash % @size
    end

    def [](key)
        idx = hash_function(key)
        dll = @store[idx]
        link = dll.head
        value = nil
        until link.nil?
            break value = link.value[1] if link.value[0] == key
            link = link.next_ptr
        end
        value
    end

    def []=(key,value)
        idx = hash_function(key)
        dll = @store[idx]
        link = find_link(key,dll) #<---------
        if link.nil?
            @number_of_items += 1
            dll.add_last([key,value])
            if @size <  @number_of_items
                arr = extract_all_items
                expand
                redistribute(arr)
            end
        else  
            link.value = [key,value]
        end
    end

    def has_key?(key)
        idx = hash_function(key)
        dll = @store[idx]
        !find_link(key,dll).nil?
    end

    def find_link(key,dll)
        ptr = dll.head
        until ptr == nil || ptr.value[0] == key
            ptr = ptr.next_ptr
        end
        ptr
    end

    def to_a
        @store.each_with_object([]) do |dll,arr|
            ptr = dll.head
            until ptr.nil?
                arr << ptr.value
                ptr = ptr.next_ptr
            end
        end
    end

    def keys
        @store.each_with_object([]) do |dll,arr|
            ptr = dll.head
            until ptr.nil?
                arr << ptr.value[0]
                ptr = ptr.next_ptr
            end
        end
    end

    def values
        @store.each_with_object([]) do |dll,arr|
            ptr = dll.head
            until ptr.nil?
                arr << ptr.value[1]
                ptr = ptr.next_ptr
            end
        end
    end

    def delete(key)
        idx = hash_function(key)
        dll = @store[idx]
        link = find_link(key,dll)
        unless link.nil?
            dll.delete(link.value)
            @number_of_items -= 1
        end
        link
    end

    def print_hash
        print'{'
        @store.each do |dll|
            next if dll.empty?
            hash_str =''
            link = dll.head
            until link.nil? 
                hash_str += link.value[0].to_s + '=>' + link.value[1].to_s + ','
                link = link.next_ptr
            end
            puts
            print hash_str
        end
        print '}'
    end

end