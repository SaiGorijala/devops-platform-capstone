output "sg_jenkins" {
  value = aws_security_group.jenkins.id
}

output "sg_sonarqube" {
  value = aws_security_group.sonarqube.id
}

output "sg_nexus" {
  value = aws_security_group.nexus.id
}

output "sg_docker" {
  value = aws_security_group.docker.id
}

output "sg_database" {
  value = aws_security_group.database.id
}