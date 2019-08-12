require_relative 'p04_linked_list'

class HashMap
  attr_accessor :store, :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if self.count >= num_buckets
    
    if include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      self.count +=1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    removal = bucket(key).remove(key)
    self.count -=1 if removal
    removal
  end

  def each
    @store.each do |linkedList| 
      linkedList.each do |node| 
        yield [node.key, node.val]
      end 
    end 
  end

  
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  
  private 
  def num_buckets
    @store.length
  end

  def resize!
    new_length = num_buckets * 2
    new_store = Array.new(new_length) {LinkedList.new}

    self.each do |k, v| 
      hashedKey = k.hash
      idx = hashedKey % new_length
      new_store[idx].append(k, v)
    end 
    @store = new_store
  end

  def bucket(key)
    hashedKey = key.hash
    idx = hashedKey % num_buckets
    @store[idx]
  end
end
