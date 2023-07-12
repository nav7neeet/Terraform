module "module1" {
  source   = "./module1"
  filename = "file.txt"
}

output "out2" {
  value = module.module1.out1
}
