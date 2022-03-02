### 安装lua5.1
```
# lua 5.4 目前有兼容性问题，安装5.1
brew install lua@5.1
ln -s /usr/local/opt/lua@5.1/bin/lua5.1 /usr/local/bin/lua5.1
# 运行lua
lua5.1
```

### 安装luarock - 依赖安装（类似maven pip）
```
brew install luarocks
# 安装5.1的依赖
luarocks --lua-dir=/usr/local/opt/lua@5.1 install lua-json
luarocks --lua-dir=/usr/local/opt/lua@5.1 install lua-json
```

### 将下载好的依赖包关联到lua lib才可以被require到
```
ln -s /Users/chenxiaojie/.luarocks/lib/lua/5.1/cjson.so  /usr/local/Cellar/lua@5.1/5.1.5_8/lib/cjson.so
ln -s /Users/chenxiaojie/.luarocks/lib/lua/5.1/json.so  /usr/local/Cellar/lua@5.1/5.1.5_8/lib/json.so
```

### 运行测试代码
```
lua5.1 lua_cjson_switch.lua
```

### 运行结果
```
{
["a"]:hello,
["c"]:123456,
["b"]:world,
["e"]:{
["1"]:hhh,
["2"]:11,
["3"]:22
 },
["d"]:123456,
["f"]:{
["a"]:hello,
["c"]:123456,
["b"]:world,
["e"]:{
["1"]:hhh,
["2"]:11,
["3"]:22
 },
["d"]:123456,
["count"]:0
 }
 }
##################################################
{"a":"hello","c":123456,"b":"world","e":["hhh","11","22"],"d":"123456","f":{"a":"hello","c":123456,"b":"world","e":["hhh","11","22"],"d":"123456","count":0}}
##################################################
{
["a"]:hello,
["c"]:123456,
["b"]:world,
["e"]:{
["1"]:hhh,
["2"]:11,
["3"]:22
 },
["d"]:123456,
["f"]:{
["a"]:hello,
["c"]:123456,
["b"]:world,
["e"]:{
["1"]:hhh,
["2"]:11,
["3"]:22
 },
["d"]:123456,
["count"]:0
 }
 }
##################################################
```