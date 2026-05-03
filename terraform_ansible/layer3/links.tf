resource "cml2_link" "l0" {
  lab_id = cml2_lab.layer3.id
  node_a = cml2_node.ex.id
  node_b = cml2_node.r1.id
  slot_a = 0
  slot_b = 0
}

resource "cml2_link" "l1" {
  lab_id = cml2_lab.layer3.id
  node_a = cml2_node.r1.id
  node_b = cml2_node.sw1.id
  slot_a = 1
  slot_b = 0
}

resource "cml2_link" "l2" {
  lab_id = cml2_lab.layer3.id
  node_a = cml2_node.r1.id
  node_b = cml2_node.sw1.id
  slot_a = 2
  slot_b = 1
}
