# gh-actions-docker-compose-up

Start containers specified in a docker-compose file.


## Inputs

### `docker-hub-username`

The username used for login to Docker Hub.

### `docker-hub-access-token`

The access token used for login to Docker Hub.  This is required if
`docker-hub-username` was set.

## `aws-access-key-id`

The access key used for login to Amazon Elastic Container Registry (Amazon ECR).

## `aws-secret-access-key`

The secret access key used for login to Amazon ECR.  This is required if
`aws-access-key-id` was set.

## `aws-region`

The AWS region where the Amazon ECR is located.  Uses `eu-west-1` by default.

## `aws-account-id`

The id of the AWS account where the Amazon ECR is located.  Usually the
tooling account's id.  This is required if `aws-access-key-id` was set.

### `service-containers`

A list of containers to start before building the primary container.

### `db-name`

The name of the database to create in the PostgreSQL container.  The
container must be named `db`.

### `apply-migrations`

**Optional** Runs `docker compose run web migrate` if set to `true`

### `working-directory`

**Optional** Specifies the working directory where the commands are run.


## Example usage

### With Docker Hub

```yaml
uses: aexeagmbh/gh-actions-docker-compose-up@main
with:
  docker-hub-username: foo
  docker-hub-access-token: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}
  service-containers: db redis
  db-name: bar
  working-directory: ./baz
```

### With Amazon ECR

```yaml
uses: aexeagmbh/gh-actions-docker-compose-up@main
with:
  aws-access-key-id: AKIAIOSFODNN7EXAMPLE
  aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  aws-account-id: 111122223333
  service-containers: db redis
  db-name: bar
  working-directory: ./baz
```
