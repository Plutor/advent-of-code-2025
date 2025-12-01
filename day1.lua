require("utils")

multMap = {L=-1, R=1}

function part1(data)
  local dial = 50
  local count = 0
  for _, d in ipairs(data) do
    local mult = multMap[string.sub(d, 1, 1)]
    local dist = tonumber(string.sub(d, 2))
    dial = dial + (mult * dist)
    while dial > 99 do
      dial = dial - 100
    end
    while dial < 0 do
      dial = dial + 100
    end
    if dial == 0 then
      count = count + 1
    end
  end
  return count
end


function part2(data)
  local dial = 50
  local count = 0
  for _, d in ipairs(data) do
    local mult = multMap[string.sub(d, 1, 1)]
    local dist = tonumber(string.sub(d, 2))
    local after = dial + (mult * dist)
    while after < 0 do
      after = after + 100
      count = count + 1
    end
    while after > 99 do
      after = after - 100
      count = count + 1
    end
    -- If we started on 0, we already counted it, so don't double count if we turn left (0 -> 99)
    if dial == 0 and mult == -1 then
      count = count - 1
    end
    -- If we land on 0, it already counted if we turn right (99 -> 0)
    if after == 0 and mult == -1 then
      count = count + 1
    end
    dial = after
  end
  return count
end

sample = {"L68",
          "L30",
          "R48",
          "L5",
          "R60",
          "L55",
          "L1",
          "L99",
          "R14",
          "L82"}
data = loadDataArray("data/day1", asStr)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
