require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end

    nil
  end

  def include?(key)
    !!get(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)

    tail.prev.next = new_node
    new_node.prev = tail.prev

    tail.prev = new_node
    new_node.next = tail

    new_node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end

    nil
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev

        node.next = nil
        node.prev = nil
        return node
      end
    end
  end

  def each(&prc)
    current_node = head

    until current_node.next == tail
      current_node = current_node.next
      prc.call(current_node)
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
