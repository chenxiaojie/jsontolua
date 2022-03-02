cjson = require "cjson"

function tableToString(t)
     local str =  "{ "
     str = str.."\n"
     for k, v in pairs(t) do
        if type(v) ~= "table" then
            str = str.."[\""..k.."\"]"
            str = str..":"
            str = str..v
            str = str..","
            str = str.."\n"
        else
            str = str.."[\""..k.."\"]"
            str = str..":"
            str = str..tableToString(v)
            str = str..","
            str = str.."\n"
        end
     end
     str = string.sub(str, 1, -3)
     str = str.."\n"
     str = str .." }"
     return str
end

local t = {
    a = "hello",
    b = "world",
    c = 123456,
    d = "123456",
    e = { "hhh", "11", "22" },
    f = {
        a = "hello",
        b = "world",
        c = 123456,
        d = "123456",
        e = { "hhh", "11", "22" },
        count = 0
    }
}

print(tableToString(t))
print("##################################################")
str_json = cjson.encode(t)
print(str_json)
print("##################################################")
t = cjson.decode(str_json)
print(tableToString(t))
print("##################################################")


