require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if map.include?(key)
      node = @map.get(key)
      update_node!(node)
      return node.val
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private
  attr_accessor :map, :store
  attr_reader :max, :prc
  def calc!(key)
    val = @prc.call(key)
    node = store.append(key, val)
    map.set(key, node)

    eject! if count > max
  end

  def update_node!(node)
    store.remove(node.key)
    store.append(node.key, node.val)
  end

  def eject!
    key = store.first.key
    store.remove(key)
    map.delete(key)
  end
end
