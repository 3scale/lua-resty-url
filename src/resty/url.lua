local tostring = tostring
local re_match = ngx.re.match
local concat = table.concat
local tonumber = tonumber
local setmetatable = setmetatable
local re_gsub = ngx.re.gsub
local select = select

local _M = {
  _VERSION = '0.2.0',

  ports = {
    https = 443,
    http = 80,
  }
}

function _M.default_port(scheme)
  return _M.ports[scheme]
end

function _M.split(url, protocol)
  if not url then
    return nil, 'missing endpoint'
  end

  if not protocol then
    protocol = 'https?'
  end

  local m = re_match(url, "^(" .. protocol .. "):\\/\\/(?:(.+)@)?([^\\/\\s]+?)(?::(\\d+))?(\\/.*)?$", 'oj')

  if not m then
    return nil, 'invalid endpoint' -- TODO: maybe improve the error message?
  end

  local scheme, userinfo, host, port, path = m[1], m[2], m[3], m[4], m[5]
  local user, pass

  if path == '/' then path = nil end

  if userinfo then
    local m2 = re_match(tostring(userinfo), "^([^:\\s]+)?(?::(.*))?$", 'oj') or {}
    user, pass = m2[1], m2[2]
  end

  return { scheme, user or false, pass or false, host, port or false, path or nil }
end

function _M.parse(url, protocol)
  local parts, err = _M.split(url, protocol)

  if err then
    return parts, err
  end

  -- https://tools.ietf.org/html/rfc3986#section-3
  return setmetatable({
    scheme = parts[1] or nil,
    user = parts[2] or nil,
    password = parts[3] or nil,
    host = parts[4] or nil,
    port = tonumber(parts[5]),
    path = parts[6] or nil
  }, { __tostring = function() return url end })
end

function _M.normalize(uri)
  local regex = [[
(                     # Capture group

  (?<!/)/             # Look for / that does not follow another /

  # Look for file:///
  (?(?<=\bfile:/)      # if...
    //                    # then look for // right after it
    |                     # else

    # Look for http:// or ftp://, etc.
    (?(?<=:/)            # if [stuff]:/
    /                  # then look for /
    |                   # else

    )
  )
)
/+                   # everything else with / after it
]]
  return re_gsub(uri, regex, '/', 'jox')
end

function _M.join(...)
  local components = {}

  for i=1, select('#', ...) do
    components[i] = tostring(select(i, ...))
  end

  return _M.normalize(concat(components, '/'))
end


return _M
