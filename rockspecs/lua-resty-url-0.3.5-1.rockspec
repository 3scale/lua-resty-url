package = "lua-resty-url"
version = "0.3.5-1"
source = {
   url = "https://github.com/3scale/lua-resty-url/archive/v0.3.5.tar.gz",
   md5 = "98d0eff455728a51513608ef208d46cc",
   dir = "lua-resty-url-0.3.5",
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
