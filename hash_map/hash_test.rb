def array_to_hash(arr)
  return 777.hash if arr.empty?
  hash_num = 0

  arr.each_with_index do |el, idx|
    hash_num ^= el % (idx + 1) ^ el * idx * arr.size
  end

  hash_num.hash
end

def hash_to_hash(hash)
  array = hash.to_a.flatten.sort
  array_to_hash(array)
end
