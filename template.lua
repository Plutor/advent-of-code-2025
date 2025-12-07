require("utils")

function part1(input)
  return #input
end

function part2(input)
  return #input
end


sample = dataArray(fromHeredoc([[
]]), asStr)
data = dataArray(fromFile("data/dayX"), asStr)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
