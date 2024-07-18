resource "google_cloud_run_service" "default" {
  name     = "hello-world"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/hello-world:latest"
      }
    }
  }
  traffics {
    percent         = 100
    latest_revision = true
  }  

}

resource "google_cloud_run_service_iam_member" "default" {
  service     = google_cloud_run_service.default.name
  location    = google_cloud_run_service.default.location
  role        = "roles/run.invoker"
  member      = "allUsers"
}

resource "google_project_service" "cloud_run_api" {
  service = "run.googleapis.com"
}




output "url" {
  value = google_cloud_run_service.default.status[0].url
}


