require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    list = store[key.hash % num_buckets]
    list.update(key, val) if list.include?(key)

    list.append(key, val)
  end

  def get(key)
    store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    store[key.hash % num_buckets].remove(key)
  end

  def each(&prc)
    store.each do |list|
      list.each { |node| prc.call(node.key, node.val) }
    end

    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  attr_reader :store

  def num_buckets
    store.length
  end

  def resize!
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
