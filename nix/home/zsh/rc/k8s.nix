{ ... }:

# Kubernetes helper functions
{
  programs.zsh.initContent = ''
    function kube-context() {
      context_name=$(kubectl config get-contexts -o name | fzf)
      kubectl config use-context ''${context_name}
    }

    function kube-exec() {
      pod=$(kubectl get pods -o name | awk -F "/" '{print $2}' | fzf)
      container=$(kubectl get pods ''${pod} -o jsonpath="{range .spec.containers[*]}{.name}{'\n'}{end}" | fzf)
      kubectl exec -it ''${pod} -c ''${container} /bin/bash
    }
  '';
}
