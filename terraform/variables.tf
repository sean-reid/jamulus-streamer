variable "region" {
  description = "GCP region"
  default     = "us-west1"
}

variable "instance_type" {
  description = "GCE instance type"
  default     = "n1-standard-1"
}

variable "key_path" {
  description = "GCE public SSH key path"
}

variable "allowed_source_ranges" {
  description = "List of allowed source IP ranges for SSH access"
  type        = list(string)
}

variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "credentials_file" {
  description = "Path to the Google Cloud service account key JSON file"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}
