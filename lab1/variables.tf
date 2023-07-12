variable "var1" {
  default = "this is a string"
  type    = string
}

variable "var2" {
  default = 123
  type    = number
}

variable "var3" {
  default = true
  type    = bool
}

variable "var4" {
  default = ["cabbage", "spinach", "cauliflower"]
  type    = list(string)
}

variable "var5" {
  default = [1, 2, 3, 4, 3]
  type    = set(number)
}

variable "var6" {
  default = [1, "ram", "shyam"]
  type    = tuple([number, string, string])
}

variable "var7" {
  default = {
    "name"            = "Hector"
    "type"            = "car"
    "choice"          = "dual tone"
    "model"           = 11
    "available_color" = ["red", "blue", "green"]
  }
  type = object({
    name            = string
    type            = string
    choice          = string
    model           = number
    available_color = list(string)
  })
}
