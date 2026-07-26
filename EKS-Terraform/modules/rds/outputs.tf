output "db_endpoint" {

  value = aws_db_instance.this.endpoint

}

output "db_port" {

  value = aws_db_instance.this.port

}

output "db_name" {

  value = aws_db_instance.this.db_name

}

output "db_arn" {

  value = aws_db_instance.this.arn

}

output "db_identifier" {

  value = aws_db_instance.this.identifier

}