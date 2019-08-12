class MaxIntSet
  def initialize(max)
    @lastNum = max
    @store = Array.new(max) {false}
  end
  attr_reader :lastNum
  attr_accessor :store

  def insert(num)
    if is_valid?(num)
      @store[num] = true 
    end 
  end

  def remove(num)
    if is_valid?(num)
      @store[num] = false 
    end 
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    if num.between?(0, lastNum)
      return true 
    else 
      raise "Out of bounds"
    end 
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    curr_bucket = self[num]

    if !curr_bucket.include?(num)
      curr_bucket.push(num)
    end
  end

  def remove(num)
    curr_bucket = self[num]

    if curr_bucket.include?(num)
      curr_bucket.delete(num)
    end
  end

  def include?(num)
    curr_bucket = self[num]
    curr_bucket.include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! unless @count < num_buckets
      
    curr_bucket = self[num]
    if !curr_bucket.include?(num)
      curr_bucket.push(num)
      @count += 1 
    end
  end 

   def remove(num)
    curr_bucket = self[num]

    if curr_bucket.include?(num)
      curr_bucket.delete(num)
      @count -=1 
    end
  end

  def include?(num)
    curr_bucket = self[num]
    curr_bucket.include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_len = num_buckets * 2 
    new_store = Array.new(new_len) {Array.new}

    @store.each do |bucket| 
      bucket.each do |num| 
        new_store[num % new_len] << num 
      end 
    end 

    @store = new_store
  end
end

