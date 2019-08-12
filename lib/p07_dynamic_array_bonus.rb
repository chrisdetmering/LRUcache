class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray

  include Enumerable 
  attr_accessor :count, :store

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_index = 0 
  end

  def [](i)
    i = i < 0 ? @count + i : i 
    return nil unless i >=0 
    @store[i]
  end

  def []=(i, val)
    if i > count
      (i - count).times {push(nil)}
    elsif i < 0 
      i = count + i 
      return nil if i < 0 
      return self.store[i] = val 
    end

    if i == count 
      resize! if self.count == capacity
      @count += 1 
    end 

    self.store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    any? {|ele| ele == val}
  end

  def push(val)
    resize! unless @count < capacity
    @store[@count] = val 
    @count += 1 
  end

  def unshift(val)
    resize! unless @count < capacity - 1

    @count.downto(1).each do |i| 
      @store[i] = @store[i - 1]
    end 
    @store[0] = val 
    @count += 1 
    @store 
  end

  def pop
    return nil if @count == 0 
    ele = @store[count - 1]
    @store[count - 1] = nil
    @count -= 1
    ele
  end

  def shift
    ele = @store[0]
    @store[0] = nil 
    @count -= 1
    (0...capacity).each  do |i| 
      if i < capacity - 1
        @store[i] = @store[i + 1]
      else
        @store[i] = nil
      end
    end 
    ele 
  end

  def first
    @store[@start_index]
  end

  def last
    @store[count - 1]
  end

  def each
   self.count.times { |i| yield self[i] } 
  end


  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless length == other.length
    each_with_index { |el, i| return false unless el == other[i] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)

    each_with_index { |ele, i| new_store[i] = ele }

    @store = new_store
  end
end



