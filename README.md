# gh-actions-docker-compose-up

Start containers specified in a docker-compose file.


## Inputs

### `docker-hub-username`

The username used for login to Docker Hub.

### `docker-hub-access-token`

The access token used for login to Docker Hub.  This is required if
`docker-hub-username` was set.

### `service-containers`

A list of containers to start before building the primary container.

### `db-name`

The name of the database to create in the PostgreSQL container.  The
container must be named `db`.


## Example usage

```yaml
uses: aexeagmbh/gh-actions-docker-compose-up
with:
  docker-hub-username: foo
  docker-hub-access-token: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}
  service-containers: db redis
  db-name: bar
```
