output "jenkins_ip" {
  value = module.ec2_jenkins.public_ip
}

output "sonarqube_ip" {
  value = module.ec2_sonarqube.public_ip
}

output "nexus_ip" {
  value = module.ec2_nexus.public_ip
}

output "docker_ip" {
  value = module.ec2_docker.public_ip
}

output "database_private_ip" {
  value = module.ec2_database.private_ip
}