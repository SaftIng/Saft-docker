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
