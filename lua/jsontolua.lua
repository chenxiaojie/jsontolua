cjson = require "cjson"

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
        -- xiaojie custom if
        for k, v in pairs(val) do
            tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1, name == "table") .. "," ..
                      (not skipnewlines and "\n" or "")
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
