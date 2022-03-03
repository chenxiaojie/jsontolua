cjson = require "cjson"

local function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function() -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

local function serializeTable(val, name, skipnewlines, depth, ignorekey)
    skipnewlines = skipnewlines or false
    depth = depth or 0

    local tmp = string.rep(" ", depth)

    -- xiaojie custom ignorekey
    if not ignorekey and name then
        if tonumber(name) then
            tmp = tmp .. "[" .. name .. "] = "
        else
            tmp = tmp .. name .. " = "
        end
    end

    if type(val) == "table" then
        tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

        local keysIsNumber = true
        for k, v in pairs(val) do
            if not tonumber(k) then
                keysIsNumber = false
                break
            end
        end

        if keysIsNumber then
            for k, v in pairsByKeys(val) do
                tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1, name == "table") .. "," ..
                        (not skipnewlines and "\n" or "")
            end
        else
            -- xiaojie custom if
            for k, v in pairs(val) do
                tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1, name == "table") .. "," ..
                        (not skipnewlines and "\n" or "")
            end
        end

        

        tmp = tmp .. string.rep(" ", depth) .. "}"
    elseif type(val) == "number" then
        tmp = tmp .. tostring(val)
    elseif type(val) == "string" then
        tmp = tmp .. string.format("%q", val)
    elseif type(val) == "boolean" then
        tmp = tmp .. (val and "true" or "false")
    else
        tmp = tmp .. "\"[inserializeable datatype:" .. type(val) .. "]\""
    end

    return tmp
end

-- from 冰雪 test, 忽略
local function serializeTable2(obj)
    local lua = ""
    local t = type(obj)
    if t == "number" then
        lua = lua .. obj
    elseif t == "boolean" then
        lua = lua .. tostring(obj)
    elseif t == "string" then
        lua = lua .. string.format("%q", obj)
    elseif t == "table" then
        lua = lua .. "{"
        for k, v in pairs(obj) do
            lua = lua .. "[" .. serializeTable2(k) .. "]=" .. serializeTable2(v) .. ","
        end
        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                lua = lua .. "[" .. serializeTable2(k) .. "]=" .. serializeTable2(v) .. ","
            end
        end
        lua = lua .. "}"
    elseif t == "nil" then
        return nil
    else
        error("can not serializeTable2 a " .. t .. " type.")
    end
    return lua
end

local function mapKeyToNumber(maps)
    local stable = {}
    for k, v in pairs(maps or {}) do
        k = tonumber(k) or k
        if type(v) == "table" then
            stable[k] = mapKeyToNumber(v)
        else
            stable[k] = v
        end
    end
    return stable
end

local function jsontolua(jsonString)
    local t = cjson.decode(jsonString)
    t = mapKeyToNumber(t)
    local tableString = serializeTable(t)
    return tableString
end

return {
    jsontolua = jsontolua
}
