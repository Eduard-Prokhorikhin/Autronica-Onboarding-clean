# Generated by Django 5.1.1 on 2024-11-08 10:23

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('autron', '0006_request_uid'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='request',
            unique_together={('software', 'uid')},
        ),
    ]