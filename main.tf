resource "aws_s3_bucket" "configuration_bucket" {
  bucket = "s3-${var.env_name}-devops-tools-configurations"
  acl    = "private"

  tags = merge(
    var.tags,
    tomap({
      "Name"="s3-${var.env_name}-devops-tools-configurations",
      "environment"=var.env_name,
      "application_role"="monitoring",
      "created_by"="terraform"
    })
  )
}

// some of the existing conf files contains the short-env-name and some of the env-name, need to decide about convention.
resource "aws_s3_bucket_object" "icinga_conf_file" {
  bucket = aws_s3_bucket.configuration_bucket.bucket
  key    = "icinga/${var.env_name}.json"
  source = "${path.module}/files/icinga/short_env_name_here.json"
}

resource "aws_s3_bucket_object" "logstash_http" {
  bucket = aws_s3_bucket.configuration_bucket.bucket
  key    = "logstash/http.conf"
  source = "${path.module}/files/logstash/http.conf"
}

resource "aws_s3_bucket_object" "logstash_conf" {
  bucket = aws_s3_bucket.configuration_bucket.bucket
  key    = "logstash/logstash.conf"
  source = "${path.module}/files/logstash/logstash.conf"
}

resource "aws_s3_bucket_object" "logstash_pipeline" {
  bucket = aws_s3_bucket.configuration_bucket.bucket
  key    = "logstash/pipelines.yml"
  source = "${path.module}/files/logstash/pipelines.yml"
}

