class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 777.hash if empty?
    hash_num = 0

    each_with_index do |el, idx|
      hash_num ^= el % (idx + 1) ^ el * idx * size
    end

    hash_num.hash
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array = to_a.map do |pair|
      [self.string_to_num(pair[0]), self.string_to_num(pair[1])]
    end.flatten.sort
    array.hash
  end

  protected
  def string_to_num(str)
    str.to_s.chars.map(&:ord).reduce(:+)
  end
end
