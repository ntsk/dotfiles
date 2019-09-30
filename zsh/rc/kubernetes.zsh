function kube-context() {
  context_name=`kubectl config get-contexts -o name | peco`
  kubectl config use-context ${context_name}
}

function kube-exec() {
  pod=`kubectl get pods -o name | awk -F "/" '{print $2}' | peco`
  container=`kubectl get pods ${pod} -o jsonpath='{.spec.containers[*].name}' | tov | peco`
  kubectl exec -it ${pod} -c ${container} /bin/bash
}

function tov() {
  sentence=''
  if [ -t 0 ] ; then
    sentence="$1"
  else
    sentence="$(cat -)"
  fi

  arr=$(echo $sentence | tr " " "\n")
  for word in $arr
  do
    echo ${word}
  done
}
