local url = require 'resty.url'
local tostring = tostring

describe('resty.url', function()

  describe('.default_port', function()
    local default_port = url.default_port

    it('returns 80 for http', function()
      assert.equal(80, default_port('http'))
    end)

    it('returns 443 for https', function()
      assert.equal(443, default_port('https'))
    end)

    it('returns nil for everything else', function()
      assert.falsy(default_port('ftp'))
    end)
  end)

  describe('.split', function()
    local split = url.split

    it('works with port', function()
      assert.same({'https', false, false, 'example.com', '8443'},
        split('https://example.com:8443'))
    end)

    it('works with user', function()
      assert.same({'https', 'user', false, 'example.com', false },
        split('https://user@example.com'))
    end)

    it('works with user and password', function()
      assert.same({'https', 'user', 'password', 'example.com', false },
        split('https://user:password@example.com'))
    end)

    it('works with just password', function()
      assert.same({'redis', false, 'password', 'example.com', false },
              split('redis://:password@example.com'))
    end)

    it('works with dots and dashes in host', function()
      assert.same({'https', false, false, 'some-test.example.com', false, '/path' },
              split('https://some-test.example.com/path'))
    end)

    it('works with underscores in host', function()
      assert.same({'http', false, false, 'http_client_backend', '1984' },
              split('http://http_client_backend:1984'))
    end)

    it('works with numbers in host', function()
      assert.same({'https', false, false, '3scale.net', false },
              split('https://3scale.net'))
    end)

    it('works with port and path', function()
      assert.same({'http', false, false, 'example.com', '8080', '/path'},
        split('http://example.com:8080/path'))
    end)

    it('removes the trailing slash', function()
      assert.same({'http', false, false, 'api.twitter.com', false },
        split('http://api.twitter.com/'))
    end)

    it('works with redis DSN', function()
      assert.same({'redis', 'user', 'pass', 'localhost', '6379', '/42' },
        split('redis://user:pass@localhost:6379/42', 'redis'))
    end)

    it('works with IPv4 host', function()
      assert.same({'https', false, false, '195.47.235.3', '443', '/path'},
        split('https://195.47.235.3:443/path'))
    end)

    it('works with IPv6 host', function()
      assert.same({'https', false, false, '[2a02:38::1001]', '443', '/path'},
        split('https://[2a02:38::1001]:443/path'))
    end)
  end)

  describe('.parse', function()
    local parse = url.parse

    it('works with port', function()
      assert.same({ scheme = 'https', host ='example.com', port = 8443 },
        parse('https://example.com:8443'))
    end)

    it('works with user', function()
      assert.same({ scheme = 'https', user = 'user', host = 'example.com' },
        parse('https://user@example.com'))
    end)

    it('works with user and password', function()
      assert.same({ scheme = 'https', user = 'user', password = 'password', host = 'example.com' },
        parse('https://user:password@example.com'))
    end)

    it('works with port and path', function()
      assert.same({ scheme = 'http', host = 'example.com', port = 8080, path = '/path'},
        parse('http://example.com:8080/path'))
    end)

    it('removes the trailing slash', function()
      assert.same({ scheme = 'http', host = 'api.twitter.com' },
        parse('http://api.twitter.com/'))
    end)

    it('works with redis DSN', function()
      assert.same({ scheme = 'redis', user = 'user', password = 'pass', host = 'localhost', port = 6379, path = '/42' },
        parse('redis://user:pass@localhost:6379/42', 'redis'))
    end)

    it('works with IPv4 host', function()
      assert.same({ scheme = 'https', host = '195.47.235.3', port = 443, path = '/path'},
        parse('https://195.47.235.3:443/path'))
    end)

    it('works with IPv6 host', function()
      assert.same({ scheme = 'https', host = '[2a02:38::1001]', port = 443, path = '/path'},
        parse('https://[2a02:38::1001]:443/path'))
    end)

    it('serializes back', function()
      local uri = 'https://user:password@example.com:1234/path?query'
      assert.equal(uri, tostring(parse(uri)))
    end)

    it('works with data-uri', function()
      local opaque = [[application/json;charset=utf-8;base64,eyJzZXJ2aWNlcyI6W3siaWQiOjEyMzQsImJhY2tlbmRfdmVyc2lvbiI6MSwicHJveHkiOnsiYXBpX2JhY2tlbmQiOiJodHRwOi8vMTI3LjAuMC4xOjgwODEiLCJob3N0bmFtZV9yZXdyaXRlIjoiZWNobyIsImhvc3RzIjpbImxvY2FsaG9zdCIsIjEyNy4wLjAuMSJdLCJiYWNrZW5kIjp7ImVuZHBvaW50IjoiaHR0cDovLzEyNy4wLjAuMTo4MDgxIiwiaG9zdCI6ImVjaG8ifSwicG9saWN5X2NoYWluIjpbeyJuYW1lIjoiYXBpY2FzdC5wb2xpY3kuYXBpY2FzdCJ9XSwicHJveHlfcnVsZXMiOlt7Imh0dHBfbWV0aG9kIjoiR0VUIiwicGF0dGVybiI6Ii8iLCJtZXRyaWNfc3lzdGVtX25hbWUiOiJoaXRzIiwiZGVsdGEiOjF9LHsiaHR0cF9tZXRob2QiOiJQT1NUIiwicGF0dGVybiI6Ii8iLCJtZXRyaWNfc3lzdGVtX25hbWUiOiJoaXRzIiwiZGVsdGEiOjF9LHsiaHR0cF9tZXRob2QiOiJQVVQiLCJwYXR0ZXJuIjoiLyIsIm1ldHJpY19zeXN0ZW1fbmFtZSI6ImhpdHMiLCJkZWx0YSI6MX1dfX1dfQ==]]
      local uri = 'data:' .. opaque
      assert.same({ scheme = 'data', opaque = opaque }, parse(uri))
    end)
  end)

  describe('.join', function()
    local join = url.join

    it('works with a slash', function()
      assert.same('https://example.com/foo', join('https://example.com', '/foo'))
    end)

    it('works without a slash', function()
      assert.same('https://example.com/foo', join('https://example.com', 'foo'))
    end)

    it('works on parsed url', function()
      local uri = url.parse('http://example.com/foo')

      assert.same('http://example.com/foo/bar', join(uri, '/bar'))
    end)
  end)

  describe('.normalize', function()
    local normalize = url.normalize

    it('normalizes slases in path', function()
      assert.same('https://example.com/foo/bar/baz', normalize('https://example.com/foo///bar//baz'))
    end)

    it('not normalizes file scheme', function()
      assert.same('file:///var/test/folder', normalize('file:///var/test//folder'))
    end)
  end)
end)
