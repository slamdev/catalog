resource "google_service_account" "account" {
  project = "${var.project_id}"
  account_id = "${var.name}"
  display_name = "${var.name}"
}

resource "google_service_account_key" "key" {
  service_account_id = "${google_service_account.account.name}"
}

resource "google_project_iam_binding" "binding" {
  count = "${length(var.roles)}"

  project = "${var.project_id}"
  role = "${var.roles[count.index]}"
  members = [
    "serviceAccount:${google_service_account.account.email}"
  ]
}
