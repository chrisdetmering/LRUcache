require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new(max)
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
   if !@map.include?(key)
    eject! unless count < @max
    calc!(key)
   else 
    node = @map.get(key)
    update_node!(node)
   end
  end

  def to_s
    'Map: ' + @map.to_s + "\n" + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)

    node = @store.append(key, val)
    @map.set(key, node)
    return val 
  end

  def update_node!(node)
    val = node.val 
    key = node.key 
    node.remove 
    new_node = @store.append(key, val)
    @map.set(key, new_node)
  end

  def eject!
    node = @store.first 
    key = node.key 
    node.remove 
    @map.delete(key)
  end
end
