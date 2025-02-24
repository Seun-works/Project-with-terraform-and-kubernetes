resource "kubernetes_pod" "next_js_pod" {
  metadata {
    name = "next-js-pod"
    labels = {
      app = "next-js"
    }
  }
  spec {
    container {
      name  = "next-js-container"
      image = "seunworks/react-with-terraform:latest"
      port {
        container_port = 3000
      }
    }
  }
}

resource "kubernetes_service" "next_js_service" {
  metadata {
    name = "next-js-service"
  }
  spec {
    selector = {
      app = "next-js"
    }
    port {
      port        = 80
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}
