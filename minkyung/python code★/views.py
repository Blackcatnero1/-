from django.shortcuts import render
from django.core import serializers
from django.http import HttpResponse
from django.views.generic import TemplateView
import json
# from dataclasses import dataclass, asdict, field, fields

from io import BytesIO
import plotly.express as px 

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

from myPw.models import Mypw 
from . import black, graph as gp

#구별 연평균 증가율
def getNums(req):
    j1 = gp.getNums()
    return HttpResponse(j1, content_type='text/json-comment-filtered')

#구별 면적당 매매가
def getPrice(req):
    tag_data = gp.getPrice()
    return render(req, 'bar/lmn.html', {'tag_data': tag_data})