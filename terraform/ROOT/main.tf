provider "aws" {
  region = var.region
}

# --------------------
# Network
# --------------------
module "network" {
  source = "./modules/network"

  vpc_cidr = "10.0.0.0/16"

  public_subnets = {
    pub1 = {
      cidr = "10.0.1.0/24"
      az   = "us-east-1a"
    }
    pub2 = {
      cidr = "10.0.2.0/24"
      az   = "us-east-1b"
    }
  }

  private_subnets = {
    priv1 = {
      cidr = "10.0.3.0/24"
      az   = "us-east-1a"
    }
  }
}

# --------------------
# Security
# --------------------
module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

# --------------------
# EC2 Instances
# --------------------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

module "ec2_jenkins" {
  source            = "./modules/ec2-jenkins"
  ami_id            = data.aws_ami.amazon_linux.id
  subnet_id         = module.network.public_subnet_ids[0]
  security_group_id = module.security.sg_jenkins
}

module "ec2_sonarqube" {
  source            = "./modules/ec2-sonarqube"
  ami_id            = data.aws_ami.amazon_linux.id
  subnet_id         = module.network.public_subnet_ids[0]
  security_group_id = module.security.sg_sonarqube
}

module "ec2_nexus" {
  source            = "./modules/ec2-nexus"
  ami_id            = data.aws_ami.amazon_linux.id
  subnet_id         = module.network.public_subnet_ids[0]
  security_group_id = module.security.sg_nexus
}

module "ec2_docker" {
  source            = "./modules/ec2-docker"
  ami_id            = data.aws_ami.amazon_linux.id
  subnet_id         = module.network.public_subnet_ids[0]
  security_group_id = module.security.sg_docker
}

module "ec2_database" {
  source            = "./modules/ec2-database"
  ami_id            = data.aws_ami.amazon_linux.id
  subnet_id         = module.network.private_subnet_ids[0]
  security_group_id = module.security.sg_database
}

data "aws_caller_identity" "current" {}