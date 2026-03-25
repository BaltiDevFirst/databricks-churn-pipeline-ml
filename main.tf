# ==========================================
# 1. DEFINICIÓN DE VARIABLES
# ==========================================
variable "project_id" {
  description = "El ID de tu proyecto en Google Cloud Platform"
  type        = string
}

variable "credentials_path" {
  description = "Ruta local hacia tu archivo JSON de credenciales de GCP"
  type        = string
  default     = "credenciales-gcp.json" 
}

variable "bucket_name" {
  description = "Nombre globalmente único para tu Data Lake en Cloud Storage"
  type        = string
}

# ==========================================
# 2. CONFIGURACIÓN DEL PROVIDER
# ==========================================
provider "google" {
  project     = var.project_id
  region      = "us-central1"
  credentials = file(var.credentials_path)
}

# ==========================================
# 3. RECURSOS A CREAR (DATA LAKE)
# ==========================================
resource "google_storage_bucket" "data_lake_bronze" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true

  labels = {
    environment = "desarrollo"
    team        = "data-engineering"
    project     = "retail-churn"
  }
}