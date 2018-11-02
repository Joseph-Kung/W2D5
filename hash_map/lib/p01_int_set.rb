require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise 'Out of bounds' unless num.between?(0, store.length - 1)
    store[num] = true
  end

  def remove(num)
    raise 'Out of bounds' unless num.between?(0, store.length - 1)
    store[num] = false
  end

  def include?(num)
    raise 'Out of bounds' unless num.between?(0, store.length - 1)
    store[num]
  end

  private
  attr_accessor :store

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].delete_at(self[num].find_index(num))
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_accessor :store
  def [](num)
    store[num % num_buckets]
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
    return nil if self.include?(num)

    self.count += 1
    resize! if self.count > store.length

    self[num] << num
  end

  def remove(num)
    return nil if !include?(num)

    self.count -= 1

    self[num].delete_at(self[num].find_index(num))
  end

  def include?(num)
    self[num].include?(num)
  end

  private
  attr_accessor :store
  attr_writer :count

  def [](num)
    store[num % num_buckets]
  end

  def num_buckets
    store.length
  end

  def resize!
    new_store = Array.new(store.length * 2) { Array.new }

    store.each do |array|
      array.each do |num|
        new_store[num % new_store.length] << num
      end
    end
    self.store = new_store
  end
end
