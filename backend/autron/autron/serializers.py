from rest_framework import serializers

from .models import *

# https://www.django-rest-framework.org/api-guide/serializers/
# Serializer example


class DepartmentSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField(max_length=100)


class SoftwareSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    name = serializers.CharField(max_length=100)
    department = DepartmentSerializer()
