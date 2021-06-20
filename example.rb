require_relative 'lru_cache/lru_cache'

# Your task for this problem is to take a sequence of data accesses 
#and simulate an LRU cache. When requested, you will output the 
#contents of the cache, ordered from least recently used to most 
#recently used.

# Input:  The input will be a series of data sets, one per line. 
#Each data set will consist of an integer N and a string of two or 
#more characters. The integer N represents the size of the cache 
#for the data set (1 ≤ N ≤ 26). The string of characters consists 
#solely of uppercase letters and exclamation marks. An upppercase 
#letter represents an access to that particular piece of data. An 
#exclamation mark represents a request to print the current contents 
#of the cache.

# For example, the sequence ABC!DEAF!B! means to acces A, B, and C 
#(in that order), print the contents of the cache, access D, E, A, 
#and F (in that order), then print the contents of the cache, then 
#access B, and again print the contents of the cache.

# The sequence will always begin with an uppercase letter and 
#contain at least one exclamation mark.

# The end of input will be signaled by a line containing only 
#the number zero.
# Output:  For each data set you should output the line 
#"Simulation S", where S is 1 for the first data set, 2 for the 
#second data set, etc. Then for each exclamation mark in the data 
#set you should output the contents of the cache on one line as a 
#sequence of characters representing the pieces of data currently 
#in the cache. The characters should be sorted in order from least 
#recently used to most recently used, with least recently occuring 
#first. You only output the letters that are in the cache; if the 
#cache is not full, then you simply will have fewer characters to 
#output (that is, do not print any empty spaces). 
#Note that because the sequence always begins with an uppercase 
#letter, you will never be asked to output a completely empty cache.

# Example input:	            Example output:
# 5 ABC!DEAF!B!                 Simulation 1
# 3 WXWYZ!YZWYX!XYXY!           ABC
# 5 EIEIO!                      CDEAF
# 0	                            DEAFB
#                               Simulation 2
#                               WYZ
#                               WYX
#                               WXY
#                               Simulation 3
#                               EIO


size = nil
i = 1

File.foreach("./input.txt") do |line|
    line = line.chomp.split(' ')
    s = line[0].to_i
    l = LruCache.new(s)
    break if s == 0
    puts "Simulation #{i}"
    line[1].each_char do |char|
        next l.display if char == '!'
        l.insert(char,nil)
    end
    i += 1
end
