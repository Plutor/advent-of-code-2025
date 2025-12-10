require("utils")

function part1(input)
  local count = 0
  local beams = {}
  for _, line in ipairs(input) do
    local newbeams = {}
    for x = 1, #line do
      local c = string.sub(line, x, x)
      if c == "S" then
        newbeams[x] = true
      elseif c == "^" and beams[x] then
        newbeams[x-1] = true
        newbeams[x+1] = true
        count = count + 1
      elseif c == "." and beams[x] then
        newbeams[x] = true
      end
    end
    beams = newbeams
  end
  return count
end

function part2(input)
  local beams = {}
  for _, line in ipairs(input) do
    local newbeams = {}
    for x = 1, #line do
      local c = string.sub(line, x, x)
      if c == "S" then
        newbeams[x] = 1
      elseif c == "^" and beams[x] then
        newbeams[x-1] = (newbeams[x-1] or 0) + beams[x]
        newbeams[x+1] = (newbeams[x+1] or 0) + beams[x]
      elseif c == "." and beams[x] then
        newbeams[x] = (newbeams[x] or 0) + beams[x]
      end
    end
    beams = newbeams
  end
  local count = 0
  for k, c in pairs(beams) do
    count = count + c
  end
  return count
end


sample = dataArray(fromHeredoc([[
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............]]), asStr)
data = dataArray(fromFile("data/day7"), asStr)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
