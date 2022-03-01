#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import jsontolua

print('{"a":"1","b":2,"c":[1,2,3]}')
print('-' * 6)
print(jsontolua.str_to_lua_table('{"a":"1","b":2,"c":[1,2,3]}'))
print('#' * 100)

print('[]')
print('-' * 6)
print(jsontolua.str_to_lua_table('[]'))
print('#' * 100)

print('[1,2,3]')
print('-' * 6)
print(jsontolua.str_to_lua_table('[1,2,3]'))
print('#' * 100)
