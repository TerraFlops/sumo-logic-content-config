locals {
  output = {
    type = local.type
    name = var.name
    search = local.search
    searchSchedule = local.searchSchedule
    description = var.description
  }
}

output "json" {
  value = jsonencode(local.output)
}

output "name" {
  value = var.name
}
