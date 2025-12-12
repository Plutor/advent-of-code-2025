require("utils")

function asCoords(s)
  local x, y, z = string.match(s, "([0-9]*),([0-9]*),([0-9]*)")
  return {x=tonumber(x), y=tonumber(y), z=tonumber(z)}
end

function distance(a, b)
  return ((a["x"]-b["x"])^2 + (a["y"]-b["y"])^2 + (a["z"]-b["z"])^2) ^ 0.5
end

function getShortestPairs(input, shortest_num)
  -- Build a list of the shortest shortest_num adjacencies
  local shortest = {}
  for aidx, a in pairs(input) do
    for bidx, b in pairs(input) do
      if aidx == bidx then
        break
      end
      local d = distance(a, b)
      local obj = {a=aidx, b=bidx, d=d}
      local pos = #shortest
      if #shortest == 0 then
        pos = 1
      else
        pos = binarysearch(shortest, d, function(a,b) return a["d"]<b end)
      end
      table.insert(shortest, pos, obj)
      while #shortest > shortest_num do
        table.remove(shortest, shortest_num+1)
      end
    end
  end
  --print(dump(shortest))
  return shortest
end

function part1(input, shortest_num)
  local shortest = getShortestPairs(input, shortest_num)
  -- Now build the circuits
  local circuits = {}
  local circuit_sizes = {}
  for aidx, _ in pairs(input) do
    circuits[aidx] = aidx
    circuit_sizes[aidx] = 1
  end
  for _, adj in pairs(shortest) do
    local acirc = circuits[adj["a"]]
    local bcirc = circuits[adj["b"]]
    if acirc ~= bcirc then
      for idx, circ in pairs(circuits) do
        if circ == bcirc then
          circuits[idx] = acirc
          circuit_sizes[acirc] = circuit_sizes[acirc] + circuit_sizes[bcirc]
          circuit_sizes[bcirc] = 0
        end
      end
    end
  end
  -- Find the sizes of the 3 largest
  table.sort(circuit_sizes, function (a,b) return a>b end)
  return circuit_sizes[1]*circuit_sizes[2]*circuit_sizes[3]
end

function part2(input)
  -- Probably could have done this smarter, but 10k worked
  local shortest = getShortestPairs(input, 10000)
  -- Now build the circuits
  local circuits = {}
  local circuit_sizes = {}
  for aidx, _ in pairs(input) do
    circuits[aidx] = aidx
    circuit_sizes[aidx] = 1
  end
  for _, adj in pairs(shortest) do
    local acirc = circuits[adj["a"]]
    local bcirc = circuits[adj["b"]]
    if acirc ~= bcirc then
      for idx, circ in pairs(circuits) do
        if circ == bcirc then
          circuits[idx] = acirc
          circuit_sizes[acirc] = circuit_sizes[acirc] + circuit_sizes[bcirc]
          circuit_sizes[bcirc] = 0
        end
      end
      -- Until there's only one circuit left
      local num_circuits = 0
      for _,s in pairs(circuit_sizes) do
        if s > 0 then
          num_circuits = num_circuits + 1
        end
      end
      if num_circuits == 1 then
        return input[adj["a"]]["x"] * input[adj["b"]]["x"]
      end
    end
  end
  return -1
end


sample = dataArray(fromHeredoc([[
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689]]), asCoords)
data = dataArray(fromFile("data/day8"), asCoords)

print("Part 1, sample data: ", part1(sample, 10))
print("Part 1, real data: ", part1(data, 1000))
print("Part 2, sample data: ", part2(sample))
print("Part 2, real data: ", part2(data))
