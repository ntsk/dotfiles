function kube-context() {
  context_name=`kubectl config get-contexts -o name | peco`
  kubectl config use-context ${context_name}
}

function kube-exec() {
  pod=`kubectl get pods -o name | awk -F "/" '{print $2}' | peco`
  container=`kubectl get pods ${pod} -o jsonpath="{range .spec.containers[*]}{.name}{'\n'}{end}" | peco`
  kubectl exec -it ${pod} -c ${container} /bin/bash
}
