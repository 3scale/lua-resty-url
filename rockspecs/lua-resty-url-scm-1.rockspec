package = "lua-resty-url"
version = "scm-1"
source = {
   url = "git+https://github.com/3scale/lua-resty-url.git"
}
description = {
   summary = "lua-resty-url - URL parser",
   detailed = "lua-resty-url - URL parser using `ngx.re`",
   homepage = "https://github.com/3scale/lua-resty-url",
   license = "Apache License 2.0"
}
dependencies = {
}
build = {
   type = "builtin",
   modules = {
      ["resty.url"] = "src/resty/url.lua"
   }
}
