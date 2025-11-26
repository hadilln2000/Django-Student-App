from django.urls import path
from . import views

urlpatterns = [   # function returns url pattern 
path('add/', views.add_student, name='add_student'),
path('getAll/', views.get_all_students, name='get_all_students'),
]