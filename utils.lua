
function loadDataArray(filename, lineValueFunc)
  local d = {}
  -- Load file
  local f = assert(io.open(filename, "r"))
  while true do
    -- Split on lines
    local s = f:read("*line")
    if s == nil then
      return d
    end
    -- Call lineValueFunc() with each line string
    table.insert(d, lineValueFunc(s))
  end
  return d
end

function asStr(lineStr)
  return lineStr
end
