# Auto-generated by fogg. Do not edit
# Make improvements in fogg, so that everyone can benefit.


provider "aws" {
  version             = "~> 1.27.0"
  region              = "us-west-2"
  profile             = "acme@infra.exmaple"
  allowed_account_ids = [000]
}

# Aliased Providers (for doing things in every region).










terraform {
  required_version = "~>0.12.5"

  backend "s3" {
    bucket         = "acme"
    dynamodb_table = "acme-auth"

    key = "terraform/acme/global.tfstate"


    encrypt = true
    region  = "us-west-2"
    profile = "acme@infra.exmaple"
  }
}

variable "env" {
  type    = "string"
  default = ""
}

variable "project" {
  type    = "string"
  default = "acme"
}


variable "region" {
  type    = "string"
  default = "us-west-2"
}


variable "component" {
  type    = "string"
  default = "global"
}


variable "aws_profile" {
  type    = "string"
  default = "acme@infra.exmaple"
}


variable "owner" {
  type    = "string"
  default = "acme-infra"
}

variable "tags" {
  type = "map"
  default = {
    project   = "acme"
    env       = ""
    service   = "global"
    owner     = "acme-infra"
    managedBy = "terraform"
  }
}




