class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
  end

  def include?(key)
  end

  def remove(key)
  end

  private
  attr_accessor :store

  def [](num)
    store[num.hash % num_buckets] = num
  end

  def num_buckets
    store.length
  end

  def resize!
  end
end
