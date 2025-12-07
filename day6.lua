require("utils")

function part1(input)
  local ops = table.remove(input, #input)
  local r = table.remove(input, 1)
  for _, row in ipairs(input) do
    for col, v in ipairs(row) do
      if ops[col] == "+" then
        r[col] = r[col] + row[col]
      else
        r[col] = r[col] * row[col]
      end
    end
  end
  local sum = 0
  for _,v in ipairs(r) do
    sum = sum + v
  end
  return sum
end

function part2(input)
  return #input
end

function asArrayOfNumbersOrStrs(line)
  local r = {}
  for w in string.gmatch(line, " *([^ ]*) *") do
    wnum = tonumber(w)
    if wnum ~= nil then
      table.insert(r, wnum)
    else
      table.insert(r, w)
    end
  end
  return r
end

sample = dataArray(fromHeredoc([[
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  ]]), asArrayOfNumbersOrStrs)
data = dataArray(fromFile("data/day6"), asArrayOfNumbersOrStrs)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
