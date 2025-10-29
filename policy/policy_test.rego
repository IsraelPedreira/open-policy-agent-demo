package kubernetes.admission

test_deny_privileged if {
  test_input := {
    "spec": {
      "containers": [
        {
          "name": "bad-container-privileged",
          "securityContext": {"privileged": true}
        }
      ]
    }
  }
  result := data.kubernetes.admission.deny with input as test_input
  count(result) > 0
}

test_allow_non_privileged if {
  # include resources so the policy's "deny if not container.resources" doesn't trigger
  test_input := {
    "spec": {
      "containers": [
        {
          "name": "good-container",
          "securityContext": {"privileged": false},
          "resources": {"limits": {"cpu": "500m", "memory": "256Mi"}}
        }
      ]
    }
  }
  result := data.kubernetes.admission.deny with input as test_input
  count(result) == 0
}

test_deny_missing_resources if {
  # a non-privileged container but without resources should still be denied by the resources rule
  test_input := {
    "spec": {
      "containers": [
        {
          "name": "bad-container-no-limits",
          "securityContext": {"privileged": false}
        }
      ]
    }
  }
  result := data.kubernetes.admission.deny with input as test_input
  count(result) > 0
}
