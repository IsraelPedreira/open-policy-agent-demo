package kubernetes.admission

# Política: nega pods com privileged=true
deny[msg] if {
  some container in input.spec.containers
  container.securityContext.privileged == true
  msg := sprintf("O container %s está executando como privilegiado", [container.name])
}

# Política: nega pods sem definição de resources
deny[msg] if {
  some container in input.spec.containers
  not container.resources
  msg := sprintf("O container %s não possui limits definidos", [container.name])
}
