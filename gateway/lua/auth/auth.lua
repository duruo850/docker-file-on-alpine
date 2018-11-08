local no_need_login_urls = {"/account/login/", "/account/register"}

local uri = ngx.var.uri

-- 不需要登录验证的url直接跳过
ngx.log(ngx.INFO,"uri",uri)
for k,v in ipairs(no_need_login_urls) do
    ngx.log(ngx.INFO,"k,", k, "v,", v)
    if uri == v then
        ngx.log(ngx.INFO,"不需要登录URL:",uri)
        return
    end
end


-- 账号有效性检查
local zhttp = require("resty.http")
local httpc = zhttp.new()
httpc:set_timeout(30)

local cjson = require "cjson"

local headers = ngx.req.get_headers()
local res = ngx.location.capture("/account/verify", {method=ngx.HTTP_POST, headers=headers});
-- ngx.log(ngx.INFO, "/account/verify res, status:", res.status, ", body: ", res.body, ", headers: ", cjson.encode(headers))


-- 检查header
if headers["KEY"] == nil or headers["VERSION"] == nil or headers["TIME"] == nil  or headers["TOKEN"] ==nil  then
    ngx.log(ngx.INFO,"verify falied, header invalid, uri,", ngx.var.uri, "headers,", cjson.encode(headers))
    ngx.exit(401)
    return
end


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
ngx.req.set_header("user_id", user_id)
ngx.req.clear_header("KEY")
ngx.req.clear_header("VERSION")
ngx.req.clear_header("TIME")
ngx.req.clear_header("TOKEN")

