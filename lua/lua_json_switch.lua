json = require "json"
cjson = require "cjson"

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

print(t)
print("##################################################")
str_json = json.encode(t)
print(str_json)
print("##################################################")
str_json = cjson.encode(t)
print(str_json)
print("##################################################")
t = json.decode(str_json)
print(t)
print("##################################################")
t = cjson.decode(str_json)
print(t)
print("##################################################")