require("utils")

function idx(x, y)
  return string.format("%d,%d", x, y)
end
function tp(btable, x, y)
  return btable[idx(x, y)]
end

function boolify(input)
  local b = {}
  b["h"] = #input
  b["w"] = input[1]:len()
  for y = 1, #input do
    local l = input[y]
    for x = 1, l:len() do
      b[idx(x, y)] = (l:sub(x,x) == '@')
    end
  end
  return b
end

function part1(input)
  local i = boolify(input)
  return #getAccessible(i)
end

function getAccessible(i)
  local acc = {}
  for y = 1, i["h"] do
    for x = 1, i["w"] do
      if not tp(i, x, y) then
        goto continue
      end
      local adj = 0
      for yd = -1, 1 do
        for xd = -1, 1 do
          if y+yd >= 1 and y+yd <= i["h"] and
             x+xd >= 1 and x+xd <= i["w"] and
             tp(i, x+xd, y+yd) then
               adj = adj + 1
          end
        end
      end
      if adj < 5 then -- because we're counting the roll itself
        table.insert(acc, idx(x, y))
      end
      ::continue::
    end
  end
  return acc
end

function part2(input)
  local i = boolify(input)
  local total = 0
  repeat
    acc = getAccessible(i)
    print("  accessible now:", #acc)
    total = total + #acc
    for a = 1, #acc do
      i[acc[a]] = false
    end
  until #acc == 0
  return total
end


sample = {"..@@.@@@@.",
          "@@@.@.@.@@",
          "@@@@@.@.@@",
          "@.@@@@..@.",
          "@@.@@@@.@@",
          ".@@@@@@@.@",
          ".@.@.@.@@@",
          "@.@@@.@@@@",
          ".@@@@@@@@.",
          "@.@.@@@.@."}
data = loadDataArray("data/day4", asStr)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
