# Saft-docker

## Usage

Adapt docker-compose.yml by changing the local path to your [Saft](https://github.com/SaftIng/Saft) files and override `/app`.

```
php:
        build: ./php
        links:
            - virtuoso
        ports:
            - 8001:80
        volumes:
            # please adapt path for local development
            - /path/to/your/local/Saft/folder:/app
```

Afterwards run:

```
docker-compose build
```

and

```
docker-compose up -d
```
to start container and let them run in background.

### Log into main container

You can log into the running container by execute:

```
docker ps -a

(will show something like)

ONTAINER ID   IMAGE       COMMAND                 CREATED       STATUS       PORTS                NAMES
b5a8e4158e22  saft_php    "docker-php-entryp..."  12 hours ago  Up 12 hours  0.0.0.0:8001->80/tcp saft_php_1
```

look for the ID of the `saft_php` container (in the example its b5a...) and use the first 3 chars for the `exec` command:

```
docker exec -it b5a bash
```

You will jump directly into the main Saft container.
