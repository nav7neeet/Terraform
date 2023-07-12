terraform {
  required_providers {
    local = {
    }
  }
}

variable "var1" {
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

variable "var2" {
  default = {
    "name"            = "Mercedes"
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

variable "var3" {
  default = {
    "name"            = "BMW"
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


variable "nameeee" {
  type        = map(string)
  description = "(optional) describe your variable"
  default = {
    key1 = "val1"
    key2 = "val2"
  }
}

variable "varX" {
  type = map(any)
  default = {
    "name"   = "BMW"
    "type"   = "car"
    "choice" = "dual tone"
    "model"  = "11"
  }
}

variable "objects" {
  type        = list(object({ id = string, attribute = string }))
  description = "list of objects"
  default = [
    {
      id        = "name1"
      attribute = "a"
    },
    {
      id        = "name2"
      attribute = "a,b"
    },
    {
      id        = "name3"
      attribute = "d"
    }
  ]
}

output "out1" {
  value = var.varX
}

# output "out" {
#   # value = [for obj in var.objects : obj.id]
#   value = [var.objects[*].id]
# }

# resource "aws_instance" "aws_instance" {
#   ami           = "ami-0cff7528ff583bf9a"
#   subnet_id     = "subnet-077467b5c673a97c8"
#   instance_type = "t2.micro"
#   key_name      = "north-virginia"
#   tags = {
#     "key" = "india"
#   }
# }
