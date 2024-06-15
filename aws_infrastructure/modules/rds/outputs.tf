output "endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_rds_cluster.aurora.endpoint
}

output "reader_endpoint" {
  description = "The reader endpoint of the RDS instance"
  value       = aws_rds_cluster.aurora.reader_endpoint
}
