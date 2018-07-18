require('resty.core')

local url = require('resty.url')
local http = require('resty.http')

local split = url.split
local parse_uri = http.parse_uri

-- require("jit.v").start("dump.txt")
-- require('jit.p').start('vl')
-- require('jit.dump').start('bsx', 'jit.log')

require('benchmark.ips')(function(b)
    b.time = 10
    b.warmup = 5

    b:report('parse_uri', function() return parse_uri(nil, 'http://example.com:8080/path?query') end)
    b:report('split', function() return split('http://example.com:8080/path?query') end)


    b:compare()
end)
