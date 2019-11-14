output "id" {
  value = "${aws_subnet.subnet.id}"
}

output "ids" {
  value = [
    "${aws_subnet.subnet.*.id}",
  ]
}


