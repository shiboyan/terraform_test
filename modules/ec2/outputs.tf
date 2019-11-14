output "ids" {
  value = [
    "${aws_instance.web.*.id}",
  ]
}


