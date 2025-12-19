require("utils")

function asCoords(s)
  local x, y = string.match(s, "([0-9]*),([0-9]*)")
  return {x=tonumber(x), y=tonumber(y)}
end

function part1(input)
  local max = 0
  for a = 1, #input do
    for b = 1, a-1 do
      local area = (math.abs(input[a]["x"] - input[b]["x"]) + 1) * (math.abs(input[a]["y"] - input[b]["y"]) + 1)
      if area > max then
        max = area
      end
    end
  end
  return max
end

function part2(input)
  return #input
end


sample = dataArray(fromHeredoc([[
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3]]), asCoords)
data = dataArray(fromFile("data/day9"), asCoords)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
--print("Part 2, real data: ", part2(data))
