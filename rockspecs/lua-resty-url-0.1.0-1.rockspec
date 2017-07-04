package = "lua-resty-url"
version = "0.1.0-1"
source = {
   url = "https://github.com/3scale/lua-resty-url/archive/v0.1.0-1.tar.gz",
   md5 = "7622ceaba3a68dc888867ca5043c3041",
   dir = "lua-resty-url-0.1.0-1",
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
