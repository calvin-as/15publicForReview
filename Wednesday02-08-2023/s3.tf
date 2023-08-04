/*
# Add S3 bucket for storing wordpress package along with assets like Images, etc.,
resource "aws_s3_bucket" "dev" {
  bucket = "webcontent-friday-challange"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
#    acl    = "private"
   lifecycle {
    prevent_destroy = false 
  }
  
}
*/

/*
# Add file
resource "aws_s3_object" "todo_list" {
  bucket = aws_s3_bucket.dev.bucket
  key    = "publicForReview/todo.txt"
  acl    = "public-read"
  source = "/Users/calvinasmus/gitRepo/15_dir_Happy_Friday/15publicForReview/todo.txt"
}
*/





#s3 logs https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest