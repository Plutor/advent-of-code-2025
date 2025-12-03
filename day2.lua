require("utils")

function part1(ranges)
  local sum = 0
  for r1, r2 in string.gmatch(ranges, "([0-9]+)-([0-9]+)") do
    r1 = tonumber(r1)
    r2 = tonumber(r2)
    -- If r1 is an odd number of digits, skip to the next power of 10
    local r1len = tostring(r1):len()
    if r1len % 2 == 1 then
      r1 = 10 ^ r1len
      r1len = r1len + 1
    end
    -- If r2 is an odd number of digits, rewind to (the previous power of 10) - 1
    local r2len = tostring(r2):len() 
    if r2len % 2 == 1 then
      r2 = (10 ^ (r2len-1)) - 1
      r2len = r2len - 1
    end
    -- If r1 > r2, there are none
    if r1 > r2 then
      goto continue
    end    
    -- From the first half of r1 to the first half of r2
    for h=tostring(r1):sub(1,r1len/2),tostring(r2):sub(1,r2len/2) do
      -- Double it and see if it's between r1 and r2
      n = tonumber(string.format("%d%d", h, h))
      if n >= r1 and n <= r2 then
        sum = sum + n
      end
    end
    ::continue::
  end
  return sum
end


function findRepeats(r1, r2)
  local reps = {}
  local r1len = tostring(r1):len()
  local r2len = tostring(r2):len()
  for n=2,r2len do
    local r1len = r1len
    local r2len = r2len
    local r1 = r1
    local r2 = r2
    -- If r1's length isn't a multiple of n, increase power of 10s until it is
    while r1len % n ~= 0 do
      r1 = 10 ^ r1len
      r1len = r1len + 1
    end
    -- If r2 length isn't a multiple of n, decrease (power of 10s)-1 until it is
    while r2len % n ~= 0 do
      r2 = (10 ^ (r2len-1)) - 1
      r2len = r2len - 1
    end
    -- If r1 > r2, there are none
    if r1 > r2 then
      goto continue
    end    
    -- From the first nth of r1 to the first half of r2
    for h=tostring(r1):sub(1,r1len/n),tostring(r2):sub(1,r2len/n) do
      -- Multiply it and see if it's between r1 and r2
      v = tonumber(string.rep(string.format("%d", h), n))
      if v >= r1 and v <= r2 then
        reps[v] = 1
      end
    end
    ::continue::
  end
  local sum = 0
  for v in pairs(reps) do
    sum = sum + v
  end
  return sum
end

function part2(ranges)
  local sum = 0
  for r1, r2 in string.gmatch(ranges, "([0-9]+)-([0-9]+)") do
    r1 = tonumber(r1)
    r2 = tonumber(r2)
    sum = sum + findRepeats(r1, r2)
  end
  return sum
end

sample = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
data = loadDataArray("data/day2", asStr)[1]

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
