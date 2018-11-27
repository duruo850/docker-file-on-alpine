local no_need_login_urls = {"/user", "/user/authorization"}
local uri = ngx.var.uri

-- 不需要登录验证的url直接跳过
for k,v in ipairs(no_need_login_urls) do
    if uri == v and ngx.req.get_method() == ngx.HTTP_POST then
        ngx.log(ngx.WARN,"不需要登录URL:",uri)
        return
    end
end

local cjson = require "cjson"
local headers = ngx.req.get_headers()

-- 检查header
if headers["Key"] == nil or headers["Version"] == nil or headers["Time"] == nil  or headers["Token"] ==nil  then
    ngx.log(ngx.INFO,"verify falied, header invalid, uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
    return
end

-- 请求account服务做账号有效性检查
local res = ngx.location.capture("/user/authorization", {method=ngx.HTTP_GET, headers=headers});
-- ngx.log(ngx.INFO, "/user/authorization res, status:", res.status, ", body: ", res.body, ", headers: ", cjson.encode(headers))

-- 判断user_id是否存在
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

local user_id = data['user_id']
if not user_id then
    ngx.log(ngx.INFO,"verify falied, not user_id, uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
end

-- 添加user_id，并清空授权的相关参数
ngx.req.set_header("User-Id", user_id)
ngx.req.clear_header("Key")
ngx.req.clear_header("Version")
ngx.req.clear_header("Time")
ngx.req.clear_header("Token")

