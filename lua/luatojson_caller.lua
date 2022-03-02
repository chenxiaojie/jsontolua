package.cpath = "/Users/chenxiaojie/.luarocks/lib/lua/5.1/?.so;" .. package.cpath
package.path = "/Users/chenxiaojie/xjworkspace/intellij/others/jsontolua/lua/?.lua;" .. package.path

local luatojson = require "luatojson"

local function readFile(luafile)
    local file = io.open(luafile, "rb")
    local content = nil
    if file then
        content = file:read("*all")
        io.close(file)
    end
    return content
end

if not arg[1] then
    print("请输入luafile")
    return
end

local fileContent = readFile(arg[1])
if not fileContent then
    print("文件不存在")
    return
end

print(luatojson.luatojson(fileContent))