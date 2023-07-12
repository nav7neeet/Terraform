variable "test" {
  default = { "k1" : "val1", "k2" : "val2", "k3" : [2.1] }
  # type    = map(string)
  type = object({
    k1 = string
    k2 = string
    k3 = list(number)
  })
}
