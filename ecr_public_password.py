#!/usr/bin/env python

from base64 import b64decode

import boto3

# Amazon ECR Public only issues authorization tokens in us-east-1.
ecr_public_client = boto3.client("ecr-public", region_name="us-east-1")
auth_token = ecr_public_client.get_authorization_token()

auth_data = auth_token["authorizationData"]
username, password = b64decode(auth_data["authorizationToken"]).decode().split(":")
assert username == "AWS"

print(password)
