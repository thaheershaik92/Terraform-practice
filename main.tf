terraform {
  required_version = ">= 0.12"
}

provider "aws" {}

data "aws_caller_identity" "current" {}

locals{
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "terrforn_state" {
  bucket = "my-tf-test-luci"

  versioning {
   enabled = true
   }

   rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "pay_per_requested"
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }
resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform_Demo"
  }
}
