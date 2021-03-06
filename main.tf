terraform {
  required_version = "~> 0.11.0"
}

provider "google" {
  region      = "${var.gcp_region }"
}

resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.project_name}-"
}

resource "google_project" "project" {
  name            = "${random_id.id.hex}"
  project_id      = "${random_id.id.hex}"
  billing_account = "${var.billing_account}"
  org_id          = "${var.org_id}"
}

resource "google_project_services" "project" {
  project = "${google_project.project.project_id}"
  services = [
    "compute.googleapis.com",
  ]
}
