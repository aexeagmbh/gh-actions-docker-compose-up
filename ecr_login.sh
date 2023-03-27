#!/usr/bin/env bash

echo "::group::Login to Amazon ECR"

PATH_TO_SCRIPT="$(dirname -- "${BASH_SOURCE[0]}")"

ECR_LOGIN_VENV="${HOME}/.venv-ecr-login"
python -m venv "${ECR_LOGIN_VENV}"
alias python="${ECR_LOGIN_VENV}/bin/python"

echo "Installing requirements…"
python -m pip install "boto3>=1.26.97"

echo "Logging in to Amazon ECR…"
python ${PATH_TO_SCRIPT}/ecr_password.py | \
    docker login --username AWS --password-stdin \
    "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"

echo "::endgroup::"
