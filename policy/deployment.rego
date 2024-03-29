package main

deny_labels[msg] {
    input.kind == "Deployment"
    not (input.spec.selector.matchLabels.app == input.spec.template.metadata.labels.app)
    msg = sprintf("Pod Template and Selector should same labels called app: %s", [input.spec.selector.matchLabels.app])
}

deny_replicas[msg] {
    input.kind == "Deployment"
    not (input.spec.replicas == 2)
    msg = sprintf("The number of replicas should be 2, but: %d", [input.spec.replicas])
}

development_selector_app := data.development.items[_].spec.selector.matchLabels.app

deny_selector_app_is_same[msg] {
    input.kind == "Service"
    service_selector_app := input.spec.selector.app
    not (service_selector_app == development_selector_app)
    msg = sprintf("Pod Template and Selector should same labels called app: %s", [service_selector_app])
}