package = "lua-resty-url"
version = "0.3.0-1"
source = {
   url = "https://github.com/3scale/lua-resty-url/archive/v0.3.0.tar.gz",
   md5 = "8af56c9f7d86d0b88642684d4832ae8b",
   dir = "lua-resty-url-0.3.0",
}
description = {
   summary = "lua-resty-url - URL parser",
   detailed = "lua-resty-url - URL parser using `ngx.re`",
   homepage = "https://github.com/3scale/lua-resty-url",
   license = "Apache License 2.0",
}
dependencies = {
}
build = {
   type = "builtin",
   modules = {
      ["resty.url"] = "src/resty/url.lua"
   }
}
