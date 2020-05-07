#!/usr/bin/env python3
# coding: utf-8

import urllib.request
import re
url = "https://rstudio.com/products/rstudio/download/"
w = urllib.request.urlopen(url).read().decode()
links = re.findall('"((http|ftp)s?://.*?)"', w)
to_download = [u[0] for u in links if "bionic/amd64" in u[0]][0]
# filename = to_download.split("/")[-1]
filename = "rstudio.deb"
urllib.request.urlretrieve(to_download, filename)
