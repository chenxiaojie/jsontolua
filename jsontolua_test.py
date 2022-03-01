#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import jsontolua

print(jsontolua.str_to_lua_table('{"a":"1","b":2,"c":[1,2,3]}'))
print(jsontolua.str_to_lua_table('[]'))
print(jsontolua.str_to_lua_table('[1,2,3]'))