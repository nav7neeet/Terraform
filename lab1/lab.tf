terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

output "var1" {
  value = var.var1
}

output "var2" {
  value = var.var2
}

output "var3" {
  value = var.var3
}

output "var4" {
  value = var.var4
}

output "var5" {
  value = var.var5
}

output "var6" {
  value = var.var6
}

output "var7" {
  value = var.var7
}

output "varX" {
  value = { for s in var.var4 : s => upper(s) }
}
