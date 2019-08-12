

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.prev = nil 
    self.next = nil 
    self
  end
end

class LinkedList
  
  include Enumerable
  attr_reader :head, :tail 

  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail 
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : self.head.next
  end

  def last
    empty? ? nil : self.tail.prev
  end

  def empty?
    self.head.next == self.tail
  end

  def get(key)
    self.each do |node|
      if node.key == key 
        return node.val
      end 
    end
    nil
  end

  def include?(key)
    self.each do |node|
      if node.key == key 
        return true 
      end 
    end
    false
  end

  def append(key, val)
    newNode = Node.new(key, val)

    self.tail.prev.next = newNode
    newNode.prev = self.tail.prev
    newNode.next = self.tail 
    self.tail.prev = newNode

    newNode
  end

  def update(key, val)
    self.each do |node|
      if node.key == key 
        node.val = val 
        return node
      end 
    end
    nil
  end

  def remove(key)
    self.each do |node|
      if node.key == key 
        node.remove 
        return node.val
      end 
    end
    nil
  end

  def each
    node = self.head.next 

    until node == self.tail
      yield node
      node = node.next
    end 
  end

  
  def to_s
    inject([]) { |acc, link| acc << "[#{link}]" }.join(", ")
  end
end

