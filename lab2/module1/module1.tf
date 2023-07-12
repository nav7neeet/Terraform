provider "local" {

}

resource "local_file" "local_file" {
  filename = var.filename
  content  = "testing modules"
}

variable "filename" {
  description = "Desired name for the file"
  type        = string
}

output "out1" {
  value = var.filename
}
