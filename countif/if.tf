variable "colors" {
  description = "color list"
  type = list(string)
  default = ["red", "blue", "green"]
}

output "for_directive_index_if" {
  value = <<EOF
%{ for i, color in var.colors }
  ${color}%{ if i < length(var.colors) - 1 }, %{ endif }
%{ endfor }
EOF
}
