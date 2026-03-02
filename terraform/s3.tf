resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = "nodejs-mysql-danlidennydeng2026"

  tags = {
    Name        = "Nodejs MySQL terraform bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "tf_s3_object" {
  bucket = aws_s3_bucket.tf_s3_bucket.bucket
	for_each = fileset("../public/images", "**")
  key = "images/${each.key}"
  source = "../public/images/${each.key}"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  # etag = filemd5("path/to/file")
}