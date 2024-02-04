resource "aws_s3_bucket" "configuration_bucket" {
  bucket = "${var.env_name}-devops-tools-configurations"

  tags = merge(
    var.tags,
    tomap({
      "Name"="${var.env_name}-devops-tools-configurations",
      "environment"=var.env_name,
      "application_role"="monitoring",
      "created_by"="terraform"
    })
  )
}

resource "aws_s3_bucket_acl" "configuration_bucket_acl" {
  bucket = aws_s3_bucket.configuration_bucket.id
  acl    = "private"
}

resource "aws_s3_object" "logstash_http" {
  bucket = aws_s3_bucket.configuration_bucket.bucket
  key    = "logstash/http.conf"
  source = "${path.module}/files/logstash/http.conf"
}

resource "aws_s3_object" "logstash_conf" {
  bucket = aws_s3_bucket.configuration_bucket.bucket
  key    = "logstash/logstash.conf"
  source = "${path.module}/files/logstash/logstash.conf"
}

resource "aws_s3_object" "logstash_pipeline" {
  bucket = aws_s3_bucket.configuration_bucket.bucket
  key    = "logstash/pipelines.yml"
  source = "${path.module}/files/logstash/pipelines.yml"
}

