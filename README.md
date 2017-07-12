lua-resty-url [![CircleCI](https://circleci.com/gh/3scale/lua-resty-url.svg?style=svg)](https://circleci.com/gh/3scale/lua-resty-url)
====

lua-resty-url - URL parser for OpenResty.


Table of Contents
=================

* [Name](#name)
* [Status](#status)
* [Description](#description)
* [Synopsis](#synopsis)
* [Methods](#methods)
    * [get](#get)
    * [set](#set)
    * [value](#value)
    * [enabled](#enabled)
    * [reset](#reset)
* [Installation](#installation)
* [TODO](#todo)
* [Community](#community)
* [Bugs and Patches](#bugs-and-patches)
* [Author](#author)
* [Copyright and License](#copyright-and-license)
* [See Also](#see-also)

Status
======

This library is considered production ready.

Description
===========

This Lua library is very simple Regex based URL parser.

This library can parse URLs and split them to components. 

Synopsis
========

```lua
http {
    server {
        location /test {
            content_by_lua_block {
                local resty_url = require 'resty.url'

                ngx.say("USER: ", resty_url.parse('http://foo:bar@example.com').user)
            }
        }
    }
}
```

[Back to TOC](#table-of-contents)

Methods
=======

All the methods are expected to be called on the module without self.

[Back to TOC](#table-of-contents)

split
---
`syntax: parts = resty_url.split(url)`

Returns a table with integer keys and parts of the URL.
Components are: scheme, user, password, host, port, path.

[Back to TOC](#table-of-contents)

parse
-------
`syntax: uri = resty_url.parse(url)`

Returns a table with components as keys.
Components are: scheme, user, password, host, port, path.

[Back to TOC](#table-of-contents)

join
----------
`syntax: url = resty_url.join(base, part, ...)`

Concatenates URI components into resulting URL. Also normalizes URI to remove double slashes.
Can concatenate objects returned by `parse` method.

[Back to TOC](#table-of-contents)

default\_port
------------
`syntax: port = resty_url.default_port(scheme)`

Returns default port for given scheme. Only http and https provided by default.

[Back to TOC](#table-of-contents)

normalize
------------
`syntax: uri = resty_url.normalize(uri)`

Removes unnecessary slashes from the URI.

[Back to TOC](#table-of-contents)

Installation
============

If you are using the OpenResty bundle (http://openresty.org ), then
you can use [opm](https://github.com/openresty/opm#synopsis) to install this package.

```shell
opm get 3scale/lua-resty-url
```

[Back to TOC](#table-of-contents)

Bugs and Patches
================

Please report bugs or submit patches by

1. creating a ticket on the [GitHub Issue Tracker](http://github.com/3scale/lua-resty-url/issues),

[Back to TOC](#table-of-contents)

Author
======

Michal "mikz" Cichra <mcichra@redhat.com>, Red Hat Inc.

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the Apache License Version 2.0.

Copyright (C) 2016-2017, Red Hat Inc.

All rights reserved.

See [LICENSE](LICENSE) for the full license.

[Back to TOC](#table-of-contents)

See Also
========
* the APIcast API Gateway: https://github.com/3scale/apicast/#readme

[Back to TOC](#table-of-contents)
