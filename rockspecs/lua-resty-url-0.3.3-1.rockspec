package = "lua-resty-url"
version = "0.3.3-1"
source = {
   url = "https://github.com/3scale/lua-resty-url/archive/v0.3.3.tar.gz",
   md5 = "f9e5a499fd9d6a401b51ff6fe448cbfe",
   dir = "lua-resty-url-0.3.3",
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
