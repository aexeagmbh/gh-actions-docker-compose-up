#!/usr/bin/env bash

echo "::group::Login to Amazon ECR"

PATH_TO_SCRIPT="$(dirname -- "${BASH_SOURCE[0]}")"

ECR_LOGIN_VENV="${HOME}/.venv-ecr-login"
python -m venv "${ECR_LOGIN_VENV}"
ECR_LOGIN_PYTHON="${ECR_LOGIN_VENV}/bin/python"

echo "Installing requirements…"
"${ECR_LOGIN_PYTHON}" -m pip install "boto3>=1.26.97"

echo "Logging in to Amazon ECR…"
"${ECR_LOGIN_PYTHON}" "${PATH_TO_SCRIPT}/ecr_password.py" | \
    docker login --username AWS --password-stdin \
    "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"

# Authenticated pulls from public.ecr.aws (e.g. awsguru/aws-lambda-adapter)
# aren't subject to the anonymous rate limit, which GitHub's runners share.
if [[ "${AWS_ECR_PUBLIC_LOGIN}" == "true" ]]; then
    echo "Logging in to Amazon ECR Public…"
    if ! "${ECR_LOGIN_PYTHON}" "${PATH_TO_SCRIPT}/ecr_public_password.py" | \
        docker login --username AWS --password-stdin public.ecr.aws; then
        echo "::warning::Login to Amazon ECR Public failed; pulls from public.ecr.aws are anonymous and may be rate limited"
    fi
fi

echo "::endgroup::"
