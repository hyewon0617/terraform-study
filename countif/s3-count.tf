provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "hyewon-s3" {
  count = 3
  bucket = "hyewon-s3-tf-${count.index}"
}
