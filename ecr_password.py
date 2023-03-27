#!/usr/bin/env python

import os
from base64 import b64decode

import boto3

ecr_client = boto3.client("ecr")
auth_token = ecr_client.get_authorization_token(
    registryIds=[os.getenv("AWS_ACCOUNT_ID")]
)
assert len(auth_token["authorizationData"]) == 1

auth_data = auth_token["authorizationData"][0]
username, password = b64decode(auth_data["authorizationToken"]).decode().split(":")
assert username == "AWS"

print(password)
