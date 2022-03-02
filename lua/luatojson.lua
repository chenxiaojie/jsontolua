cjson = require "cjson"

local cjson2 = cjson.new()
-- cjson2.encode_sparse_array(false, 10000)
-- https://www.kyne.com.au/~mark/software/lua-cjson-manual.html#encode
cjson2.encode_sparse_array(true)

local function toTable(str)
    if str == nil or type(str) ~= "string" then
        return
    end

    return loadstring("return " .. str)()
end

local function mapKeyToString(maps)
    local stable = {}
    for k, v in pairs(maps or {}) do
        k = tostring(k) or k
        -- if type(v) == "table" then ======== xiaojie custom
        if k ~= "table" and type(v) == "table" then
            stable[k] = mapKeyToString(v)
        else
            stable[k] = v
        end
    end
    return stable
end

local function luatojson(luaString)
    local t = toTable(luaString)
    t = mapKeyToString(t)
    local str_json = cjson2.encode(t)
    return str_json
end

return {
    luatojson = luatojson
}
