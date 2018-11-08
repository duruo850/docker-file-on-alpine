#!/usr/bin/python3
# coding=utf-8
"""
Created on 2018/11/8 

@author: JAY
"""
from urllib import request, error

url="http://192.168.1.136/account/test"

headers = {
    'X-KEY': "--key--",
    'X-VERSION': "--version--",
    'X-SEED': "--seed--",
    'X-TOKEN': "--token--",
}

req = request.Request(url=url, headers=headers, method="POST")
try:
    uopen = request.urlopen(req)
    status = uopen.status
    rdata = uopen.read()
except error.HTTPError as e:
    status = e.status
    rdata = e.read()
print("status,", status, "rdata", rdata)