// create S3--------------------------------------------------------------------------------
resource "aws_s3_bucket" "avs_s3" {
  bucket = var.s3_file_bucket_name
  acl    = "private"

  force_destroy = true // allow terraform destroy it even if the bucket is not empty

  lifecycle_rule {
    enabled = true
    transition {
        days          = 30
        storage_class = "STANDARD_IA" # or "ONEZONE_IA"
      }
  }

  // enable default encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = {
    Name        = "avs s3"
  }
}

// Create folder of avs
resource "aws_s3_bucket_object" "avs_base_folder" {
    bucket = aws_s3_bucket.avs_s3.id
    acl    = "private"
    key    = "avs/"
    # source = var.s3_bucket_object_source
}

// Create bucket for CICD
resource "aws_s3_bucket" "avs_cicd" {
  bucket = var.s3_codedeploy_bucket_name
  acl    = "private"

  force_destroy = true // allow terraform destroy it even if the bucket is not empty

  lifecycle_rule {
    enabled = true
    expiration {
      days = 30
    }
  }

  // enable default encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = {
    Name        = "avs s3"
  }
}