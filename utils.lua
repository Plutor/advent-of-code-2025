
function loadDataArray(filename, lineValueFunc)
  return dataArray(fromFile(filename), lineValueFunc)
end

function dataArray(input, lineValueFunc)
  local d = {}
  for _,v in ipairs(input) do
    table.insert(d, lineValueFunc(v))
  end
  return d
end

function fromFile(filename)
  local d = {}
  -- Load file
  local f = assert(io.open(filename, "r"))
  while true do
    -- Split on lines
    local s = f:read("*line")
    if s == nil then
      return d
    end
    table.insert(d, s)
  end
  return d
end

function fromHeredoc(s)
  -- From https://stackoverflow.com/questions/72298718/split-a-string-on-new-lines-but-include-empty-lines
  local result = {};
  for line in string.gmatch(s .. "\n", "(.-)\n") do
      table.insert(result, line);
  end
  return result
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