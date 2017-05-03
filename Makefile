default:
	make build
	make run
	docker exec -it saft_php_1 bash

build:
	docker-compose build

clean:
	-@docker ps -a -q | xargs docker stop
	-@docker ps -a -q | xargs docker rm
	-@docker volume ls -f dangling=true -q| xargs docker volume rm
	docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi -f

psa:
	docker ps -a

refresh:
	make stop
	make clean
	make build
	make run

run:
	docker-compose up -d --remove-orphans

stop:
	docker-compose down
