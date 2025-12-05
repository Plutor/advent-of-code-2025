require("utils")

function part1(d)
  local sum = 0
  for l=1,#d do
    sum = sum + joltageOf(d[l])
  end
  return sum
end

function joltageOf(s)
  -- Go right to left, tracking the highest digit we've seen
  -- and combining it with the current digit
  local r = tonumber(s:sub(#s,#s))
  --print(s,r)
  local j = 0
  for i = #s-1, 1, -1 do
    local l = tonumber(s:sub(i, i))
    local curj = l*10 + r
    --print(l, r, curj)
    if curj > j then
      j = curj
    end
    if l > r then
      r = l
    end
  end
  return j
end

function part2(d)
  local sum = 0
  for l=1,#d do
    sum = sum + staticJoltageOf(d[l])
  end
  return sum
end

function staticJoltageOf(s)
  -- Start with the rightmost 12 digits
  local jarr = {}
  for i = #s-11, #s do
    table.insert(jarr, tonumber(s:sub(i,i)))
  end
  -- Consider each digit in the rest of the input from right to left
  for i = #s-12, 1, -1 do
    table.insert(jarr, 1, tonumber(s:sub(i,i)))
    -- Push it on the front find the first digit that's <= the following one, and drop it
    for rem = 1, #jarr-1 do
      if jarr[rem] < jarr[rem+1] then
        table.remove(jarr, rem)
        goto continue
      end
    end
    -- If we got here, drop the last digit
    table.remove(jarr, #jarr)
    ::continue::
  end
  -- Build the number
  local j = 0
  for i = 1, #jarr do
    j = j * 10 + jarr[i]
  end
  return j
end


sample = {"987654321111111",
          "811111111111119",
          "234234234234278",
          "818181911112111"}
data = loadDataArray("data/day3", asStr)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
