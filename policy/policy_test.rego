package kubernetes.admission

test_deny_privileged if {
  test_input := {
    "spec": {
      "containers": [
        {
          "name": "bad-container",
          "securityContext": {"privileged": true}
        }
      ]
    }
  }
  result := data.kubernetes.admission.deny with input as test_input
  count(result) > 0
}

test_allow_non_privileged if {
  test_input := {
    "spec": {
      "containers": [
        {
          "name": "good-container",
          "securityContext": {"privileged": false}
        }
      ]
    }
  }
  result := data.kubernetes.admission.deny with input as test_input
  count(result) == 0
}
