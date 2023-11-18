package main

test_deny_replicas_fail {
    deny_replicas[msg1] with input as {
        "kind": "Deployment",
        "metadata": {
            "name": "test-deployment"
        },
        "spec": {
            "replicas": 1
        }
    }
    msg1 == "The number of replicas should be 2, but: 1"
}

test_deny_labels_fail {
    deny_labels[msg2] with input as {
        "kind": "Deployment",
        "metadata": {
            "name": "test-deployment"
        },
        "spec": {
            "selector": {
                "matchLabels": {
                    "app": "test-app-1"
                }
            },
            "template": {
                "metadata": {
                    "labels": {
                        "app": "test-app-2"
                    }
                }
            }
        }
    }
    msg2 == "Pod Template and Selector should same labels called app: test-app-1"
}

test_deny_selector_app_is_same {
    deny_selector_app_is_same[msg3] with input as {
        "kind": "Service",
        "spec": {
            "selector": {
                "app": "test-app-2"
            }
        }
    } with development_selector_app as "test-app-1"
    msg3 == "Pod Template and Selector should same labels called app: test-app-2"
}