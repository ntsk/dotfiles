function docker-ps-names() {
  docker ps --format "{{.ID}}\t{{.Names}}"
}

function docker-exec() {
  docker exec -it `docker-ps-names | peco | cut -f 1` /bin/bash
}

function docker-kill-all() {
  docker kill $(docker ps -q)
}

function docker-rmi() {
  docker rmi `docker images | tail -n +2 | peco | awk '{print $3}'`
}

function docker-logs() {
  docker logs `docker-ps-names | peco | cut -f 1` --follow
}
