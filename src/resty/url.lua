local tostring = tostring
local re_match = ngx.re.match
local concat = table.concat
local tonumber = tonumber
local setmetatable = setmetatable
local re_gsub = ngx.re.gsub
local select = select
local find = string.find
local sub = string.sub

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

function _M.scheme(url)
    local start = find(url, ':', 1, true)

    if start then
      return sub(url, 1, start - 1), sub(url, start + 1)
    end
end

local abs_pattern = [[\/\/(?:(?<userinfo>.+)@)?(?<host>[^\/\s]+?)(?::(?<port>\d+))?(?<path>\/.*)?$]]
local http_pattern = '^https?$'

function _M.split(url, protocol)
  if not url then
    return nil, 'missing endpoint'
  end

  local scheme, opaque = _M.scheme(url)

  if not scheme then return nil, 'missing scheme' end

  if protocol and not re_match(scheme, protocol, 'oj') then
    return nil, 'invalid protocol'
  end

  local m = re_match(url, abs_pattern, 'oj')

  if not m then
    if re_match(scheme, http_pattern, 'oj') then
      return nil, 'invalid endpoint'
    end

    return { scheme, opaque = opaque }
  end

  local userinfo, host, port, path = m.userinfo, m.host, m.port, m.path
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
    path = parts[6] or nil,
    opaque = parts.opaque,
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
