# Generated by Django 5.1.1 on 2024-11-08 10:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('autron', '0005_software_servicenow_link'),
    ]

    operations = [
        migrations.AddField(
            model_name='request',
            name='uid',
            field=models.CharField(default='No UID provided', max_length=100),
        ),
    ]
