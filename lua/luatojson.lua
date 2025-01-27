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
        if k ~= "table" and k ~= "group" and type(v) == "table" then
            stable[k] = mapKeyToString(v)
        elseif k == "group" then
            local len = 0
            for _, _ in pairs(v) do
                len = len + 1
            end

            if len == 0 then
                cjson2.encode_empty_table_as_object(false) 
            end
            stable[k] = v
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
