#!/usr/bin/python3
# coding=utf-8
"""
Created on 2018/11/28 

@author: JAY
"""
import pytest
from utils import logger
from utils.web.request import http_requester

gateway_host = "http://192.168.1.136"


@pytest.mark.parametrize(('url', "method"), (
    (gateway_host + "/user/authorization", "GET"),
))
def test_disable_url(url, method):
    """
    禁止访问的url
    """
    res = http_requester(url, json_loads=False, method=method)
    print(res)
    assert res.status == 401


@pytest.mark.parametrize(('url', "method"), (
    (gateway_host + "/user/phone", "GET"),
    (gateway_host + "/user/user_name", "GET"),
    (gateway_host + "/sms_code", "POST"),
    (gateway_host + "/user", "POST"),
    (gateway_host + "/user/authorization", "POST"),
))
def test_auth_url(url, method):
    """
    授权访问的url
    """
    res = http_requester(url, json_loads=False, method=method)
    print(res)
    assert res.status in (200, 404)


if __name__ == '__main__':
    logger.init_log("test_gateway")
    pytest.main()
