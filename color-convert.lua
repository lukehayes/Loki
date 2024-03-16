
local colors = {}


--colors = {
--"0x040026",
--"0x004bc0",
--"0x0097ec",
--"0x00f3fc",
--"0xffbcff",
--"0xd569f6",
--"0x6c1fd3",
--}

--colors = {
--"#040026",
--"#004bc0",
--"#0097ec",
--"#00f3fc",
--"#ffbcff",
--"#d569f6",
--"#6c1fd3",

--}

function replace_hash(s)
    return string.gsub(s, "#", "0x")
end

function convert_to_hex(c)

    local color_table = {}

    for k,c in ipairs(c) do
        table.insert(color_table, replace_hash(c))
    end

    return color_table
end



function make_struct(id, r, g, b, a)
    a = a or 255
    return "Col_" .. id .. " :: rl.Color { " .. tonumber(r) .. ", ".. tonumber(g) .. ", " .. tonumber(b) .. ", " .. a .."}"
end

for k,c in ipairs(colors) do
    
    local r = "0x" .. string.sub(c, 3,4)
    local g = "0x" .. string.sub(c, 5,6)
    local b = "0x" .. string.sub(c, 7,8)

    color_struct = make_struct(k,r,g,b)

    print(replace_hash(c))

    print(color_struct)

end


io.write("Enter list of hexadecimal colors....")
input = io.read()
repeat
    print(input)
    input = io.read()
    --input = io.flush()
until input == "done"

for k,c in ipairs(colors) do
    print(k, c)
end

print("Done")
