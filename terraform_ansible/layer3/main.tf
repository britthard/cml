terraform {
  required_providers {
    cml2 = {
      source  = "registry.terraform.io/ciscodevnet/cml2"
    }
  }
} 

variable "ip" {
  type = string
  default = "0.0.0.0"
}

variable "username" {
  type = string
  default = "root"
}

variable "password" {
  type = string
  default = "toor"
}

provider "cml2" {
  address = var.ip
  username = var.username
  password = var.password
  skip_verify = true
  named_configs = true
}

resource "cml2_lab" "layer3" {
  title = "layer3"
  description = "layer3"
}

resource "cml2_node" "ex" {
  lab_id = cml2_lab.layer3.id
  nodedefinition = "external_connector"
  configurations = [
    {
      content = "System Bridge"
      name = "default"
    }
  ]
  x = -200
  y = 0
  label = "ex"
}

resource "cml2_node" "r1" {
  lab_id = cml2_lab.layer3.id
  nodedefinition = "iol-xe"
  x = 0
  y = 0
  label = "r1"
  configuration = file("r1.txt")
}

resource "cml2_node" "sw1" {
  lab_id = cml2_lab.layer3.id
  nodedefinition = "ioll2-xe"
  x = 200
  y = 0
  label = "sw1"
  configuration = file("sw1.txt")
}
