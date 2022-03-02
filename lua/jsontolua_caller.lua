-- package.path = "lua/?.lua;"..package.path

local jsontolua = require "lua/jsontolua"
local luatojson = require "lua/luatojson"

local function readFile(jsonfile)
    local file = io.open(jsonfile, "rb")
    local content = nil
    if file then
        content = file:read("*all")
        io.close(file)
    end
    return content
end

if not arg[1] then
    print("请输入jsonfile")
    return
end

-- local fileContent = readFile("/Users/chenxiaojie/xjworkspace/intellij/others/jsontolua/demo.json")
local fileContent = readFile(arg[1])
if not fileContent then
    print("文件不存在")
    return
end

tableString = jsontolua.jsontolua(fileContent)
print(tableString)
-- print(luatojson.luatojson(tableString))