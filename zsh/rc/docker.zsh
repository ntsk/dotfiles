function docker-ps-names() {
  docker ps --format "{{.ID}}\t{{.Names}}"
}

function docker-exec() {
  docker exec -it `docker-ps-names | peco | cut -f 1` /bin/bash
}
