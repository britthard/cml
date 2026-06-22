terraform {
  required_providers {
    cml2 = {
      source  = "registry.terraform.io/ciscodevnet/cml2"
    }
  }
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
  configuration = templatefile("r1.tftpl", {
    sshuser = var.sshuser
    sshpw = var.sshpw
    mgmtip = "192.168.102.1"
    mask = "255.255.255.0"
  })
}

resource "cml2_node" "sw1" {
  lab_id = cml2_lab.layer3.id
  nodedefinition = "ioll2-xe"
  x = 200
  y = 0
  label = "sw1"
  configuration = templatefile("sw1.tftpl", {
    sshuser = var.sshuser
    sshpw = var.sshpw
    hostname = "sw1"
    mgmtip = "10.0.0.2"
    mask = "255.255.255.0"
  })
}
