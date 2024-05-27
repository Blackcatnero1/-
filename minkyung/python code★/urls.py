from django.contrib import admin
from django.urls import path, include
from django.views.generic import ListView, DetailView
from myPw.models import Mypw

from . import views

urlpatterns = [
    #BAR 요청처리
    path('getNums/', views.getNums, name='g1'),
    path('getPrice/', views.getPrice, name='p1'),
]
