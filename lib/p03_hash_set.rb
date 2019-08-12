class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(obj)
    resize! unless @count < num_buckets
      
    curr_bucket = self[obj]
    if !curr_bucket.include?(obj)
      curr_bucket.push(obj)
      @count += 1 
    end
  end 

   def remove(obj)
    curr_bucket = self[obj]

    if curr_bucket.include?(obj)
      curr_bucket.delete(obj)
      @count -=1 
    end
  end

  def include?(obj)
    curr_bucket = self[obj]
    curr_bucket.include?(obj)
  end

  private

  def [](obj)
    @store[obj.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_len = num_buckets * 2 
    new_store = Array.new(new_len) {Array.new}

    @store.each do |bucket| 
      bucket.each do |obj| 
        new_store[obj.hash % new_len] << obj 
      end 
    end 

    @store = new_store
  end
end
