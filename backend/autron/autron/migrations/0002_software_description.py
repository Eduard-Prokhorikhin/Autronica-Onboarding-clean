# Generated by Django 5.1.1 on 2024-10-29 11:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("autron", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="software",
            name="description",
            field=models.CharField(default="No description provided", max_length=500),
        ),
    ]
