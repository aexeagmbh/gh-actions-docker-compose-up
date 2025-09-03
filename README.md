# gh-actions-docker-compose-up

Build and start Docker Compose services with optional Amazon ECR and Docker Hub login.


## Inputs

All inputs are optional, but either credentials for the Docker Hub or
Amazon Elastic Container Registry (Amazon ECR) are recommended to avoid
issues with rate limits.

### `docker-hub-username`

The username used for login to Docker Hub.

### `docker-hub-access-token`

The access token used for login to Docker Hub.  This is required if
`docker-hub-username` was set.

## `aws-region`

The AWS region where Amazon ECR is located.  Uses `eu-west-1` by default.

## `aws-role-to-assume`

The Amazon Resource Name (ARN) of the role to assume.  Uses the role
`GitHub-OIDC-ECR-ReadOnly` in the `tooling` account by default.

## `aws-role-session-name`

AWS role session name.  This input is required when Amazon ECR should be used.

## `aws-codeartifact-region`

The AWS region where AWS CodeArtifact is located.  Uses `eu-west-1` by default.

## `aws-codeartifact-role-to-assume`

The Amazon Resource Name (ARN) of the role to assume for CodeArtifact.  Uses the role
`GitHub-OIDC-CodeArtifact-Python-ReadOnly` in the `tooling` account by default.

## `aws-codeartifact-role-session-name`

AWS role session name for CodeArtifact.  This input is required when AWS CodeArtifact
should be used.

### `service-profiles`

The docker compose service profiles to start before building the primary container.
For more information about service profiles, see
https://docs.docker.com/compose/how-tos/profiles/

### `db-name`

The name of the database to create in the PostgreSQL container.  The
container must be named `db`.

### `apply-migrations`

**Optional** Runs `docker compose run web migrate` if set to `true`

### `working-directory`

Specifies the working directory where the commands are run.  Uses `./` by
default.


## Example usage

### With Docker Hub

```yaml
uses: aexeagmbh/gh-actions-docker-compose-up@main
with:
  docker-hub-username: foo
  docker-hub-access-token: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}
  service-profile: services
  db-name: bar
  working-directory: ./baz
```

### With Amazon ECR

```yaml
uses: aexeagmbh/gh-actions-docker-compose-up@main
with:
  aws-role-session-name: <repo-name>-ECR-Pull
  service-profile: db,redis
  db-name: bar
  working-directory: ./baz
```
