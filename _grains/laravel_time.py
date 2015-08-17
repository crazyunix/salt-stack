#!/usr/bin/env python
# encoding: utf-8

import datetime

def last():
    grains = {}
    grains['last'] = datetime.datetime.now().strftime("%Y%m%d%H%M")
    return grains
