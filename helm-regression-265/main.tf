provider "helm" {}

locals {
  mykeys = ["aaa", "bbb", "ccc"]
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "app" {
  repository = "${data.helm_repository.stable.name}"
  name       = "myapp"
  chart      = "stable/unbound"

  reuse_values = true

  set {
    name  = "myinfo.keys"
    value = "{${join(",", local.mykeys)}}"
  }
}
