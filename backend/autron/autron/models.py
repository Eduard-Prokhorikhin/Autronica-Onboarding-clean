from django.db import models
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType

# Generic request resolver model for fields that are common to all request resolvers. 
# You are not to create an instance of this model directly. Instead, you should create an instance of a subclass of this model.
class RequestResolver(models.Model):
    name = models.CharField(max_length=100)

    def handle_request(self, request):
        raise NotImplementedError("Subclasses must implement this method")

    def __str__(self):
        return self.name
    

# Subclasses of RequestResolver model. This resolver will be used for the software that need to send an email to request access.
class EmailRequestResolver(RequestResolver):
    email_address = models.EmailField()
    email_subject = models.CharField(max_length=100)
    email_body = models.TextField()

    def handle_request(self, request):
        # Logic to send an email
        pass

# Subclasses of RequestResolver model. This resolver will be used for the software that need to call an external API (servicenow) to request access.
class APIRequestResolver(RequestResolver):
    api_endpoint = models.URLField()
    

    def handle_request(self, request):
        # Logic to call an external API
        pass

# Software model that uses the generic foreign key to link to the resolver model.
class Software(models.Model):
    name = models.CharField(max_length=100)
    department = models.ForeignKey('Department', on_delete=models.CASCADE)
    description = models.TextField()
    resolver_content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    resolver_object_id = models.PositiveIntegerField()
    resolver = GenericForeignKey('resolver_content_type', 'resolver_object_id')

    def __str__(self):
        return self.name