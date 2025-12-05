require("utils")

function part1(input)
  local ranges = {}
  local ingredients = {}
  for l = 1, #input do
    s, e = string.match(input[l], "([0-9]*)-([0-9]*)")
    if s ~= nil then
      r = {s=tonumber(s), e=tonumber(e)}
      table.insert(ranges, r)
    elseif input[l] ~= "" then
      table.insert(ingredients, tonumber(input[l]))
    end
  end
  table.sort(ingredients)
  
  local fresh = {}
  for i = 1, #ranges do
    local iidx = binarysearch(ingredients, ranges[i]["s"])
    while ingredients[iidx] <= ranges[i]["e"] do
      table.insert(fresh, ingredients[iidx])
      table.remove(ingredients, iidx)
    end
  end

  return #fresh
end

function binarysearch(haystack, needle)
  local s = 1
  local e = #haystack
  while s < e do
    local mid = math.floor((s + e)/2)
    if haystack[mid] == needle then
      return mid
    elseif haystack[mid] < needle then
      s = mid + 1
    else
      e = mid
    end
  end
  return s
end

function part2(input)
  local ranges = {}
  for l = 1, #input do
    s, e = string.match(input[l], "([0-9]*)-([0-9]*)")
    if s ~= nil then
      r = {s=tonumber(s), e=tonumber(e)}
      table.insert(ranges, r)
    end
  end
  table.sort(ranges, function (a,b) return a["s"] < b["s"] end)
  local count = 0
  for i = 1, #ranges do
    if ranges[i] == nil then
      break
    end
    while i < #ranges and ranges[i+1]["s"] <= ranges[i]["e"] do
      if ranges[i+1]["e"] > ranges[i]["e"] then
        ranges[i] = {s=ranges[i]["s"], e=ranges[i+1]["e"]}
      end
      table.remove(ranges, i+1)
    end
    count = count + (ranges[i]["e"] - ranges[i]["s"] + 1)
  end
  return count
end


sample = {"3-5",
          "10-14",
          "16-20",
          "12-18",
          "",
          "1",
          "5",
          "8",
          "11",
          "17",
          "32"}
data = loadDataArray("data/day5", asStr)

print("Part 1, sample data: ", part1(sample))
print("Part 1, real data: ", part1(data))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
