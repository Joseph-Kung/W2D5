class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self.count += 1

    resize! if self.count > store.length

    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return nil unless include?(key)

    self.count -= 1
    self[key].delete_at(self[key].find_index(key))
  end

  private
  attr_accessor :store
  attr_writer :count

  def [](num)
    store[num.hash % num_buckets]
  end

  def num_buckets
    store.length
  end

  def resize!
    new_store = Array.new(store.length * 2) { [] }

    store.each do |array|
      array.each do |el|
        new_store[el.hash % new_store.length] << el
      end
    end

    store = new_store

  end
end
