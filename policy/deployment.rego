package main

deny_labels[msg] {
    input.kind == "Deployment"
    not (input.spec.selector.matchLabels.app == input.spec.template.metadata.labels.app)
    msg = sprintf("Pod Template and Selector should same labels called app: %s", [input.metadata.name])
}

deny_replicas[msg] {
    input.kind == "Deployment"
    not (input.spec.replicas == 2)
    msg = sprintf("The number of replicas should be 2, but: %d", [input.spec.replicas])
}

selector_app_is_same[msg] {
    input.kind == "Service"
    service_selector_app := input.spec.selector.app
    development_selector_app := data.development.items[_].spec.selector.matchLabels.app
    not (service_selector_app == development_selector_app)
    msg = sprintf("Pod Template and Selector should same labels called app: %s", [development_selector_app])
}