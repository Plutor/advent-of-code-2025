
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

-- From https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end