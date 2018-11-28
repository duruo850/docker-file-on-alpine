local uri = ngx.var.uri

-- disable urls to access
local disable_urls = {{"/user/authorization", "GET"},}

for k,v in ipairs(disable_urls) do
    if uri == v[1] and ngx.req.get_method() == v[2] then
        ngx.log(ngx.WARN,"disable URL:",uri)
        ngx.exit(401)
        return
    end
end


-- auths url not need to check authorization
local auth_urls = {{"/user/phone", "GET"}, {"/user/user_name", "GET"}, {"/sms_code", "POST"}, {"/user", "POST"}, {"/user/authorization", "POST"}}

for k,v in ipairs(auth_urls) do
    if uri == v[1] and ngx.req.get_method() == v[2] then
        ngx.log(ngx.WARN,"auth URL:",uri)
        return
    end
end

local cjson = require "cjson"
local headers = ngx.req.get_headers()

-- check header
if headers["Key"] == nil or headers["Version"] == nil or headers["Time"] == nil  or headers["Token"] ==nil  then
    ngx.log(ngx.INFO,"verify falied, header invalid, uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
    return
end

-- check account authorization
local res = ngx.location.capture("/user/authorization", {method=ngx.HTTP_GET, headers=headers});
-- ngx.log(ngx.INFO, "/user/authorization res, status:", res.status, ", body: ", res.body, ", headers: ", cjson.encode(headers))

-- check status
if res.status ~= 200  then
    ngx.log(ngx.INFO,"verify falied, status error:", res.status, "uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
    return
end

local res_body = cjson.decode(res.body)
if not res_body then
    ngx.log(ngx.INFO,"verify falied, not res_body, uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
    return
end

data = res_body['data']
if not data then
    ngx.log(ngx.INFO,"verify falied, not data, uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
    return
end

-- check user_id
local user_id = data['user_id']
if not user_id then
    ngx.log(ngx.INFO,"verify falied, not user_id, uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
end

-- add user_id to header，clear other auth headers
ngx.req.set_header("User-Id", user_id)
ngx.req.clear_header("Key")
ngx.req.clear_header("Version")
ngx.req.clear_header("Time")
ngx.req.clear_header("Token")

