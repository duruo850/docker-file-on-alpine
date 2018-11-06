local no_need_login_urls = {"/user/login/", "/usr/register"}

local uri = ngx.var.uri

# 不需要登录验证的url直接跳过
ngx.log(ngx.INFO,"uri",uri)
for k,v in ipairs(no_need_login_urls) do
    ngx.log(ngx.INFO,"k,", k, "v,", v)
    if uri == v then
        ngx.log(ngx.INFO,"不需要登录URL:",uri)
        return
    end
end


# 账号有效性检查
local zhttp = require("resty.http")
local httpc = zhttp.new()
httpc:set_timeout(30)

url = "http://account/valid/"
local res, err_ = httpc:request_uri(url, {
    method = "GET",
    headers = {
        ["Content-Type"] = "application/x-www-form-urlencoded",
    }
})

ngx.log(ngx.INFO, "res,", res.status, res.body)

local cjson = require "cjson"
local unjson = cjson.decode(res.body)
ngx.log(ngx.INFO, "user_id,", res["user_id"])

# 判断user_id是否存在
if res.status == 200 and res["user_id"]
    ngx.header.user_id = res["user_id"]
    return res.body, err_
else
    ngx.log(ngx.INFO,"no cookie, uri:",uri)
    ngx.exit(401)
end

