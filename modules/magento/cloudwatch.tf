resource "random_string" "log_suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_cloudwatch_log_group" "magento-exception-log" {
  name              = "/magento-exception-log-${random_string.log_suffix.result}"
  retention_in_days = "90"

  tags = {
    Application = "magento"
    Terraform   = true
  }
}

resource "aws_cloudwatch_log_group" "magento-system-log" {
  name              = "/magento-system-log-${random_string.log_suffix.result}"
  retention_in_days = "90"

  tags = {
    Application = "magento"
    Terraform   = true
  }
}

resource "aws_cloudwatch_log_group" "magento-debug-log" {
  name              = "/magento-debug-log-${random_string.log_suffix.result}"
  retention_in_days = "90"

  tags = {
    Application = "magento"
    Terraform   = true
  }
}

resource "aws_cloudwatch_log_group" "magento-cron-log" {
  name              = "/magento-cron-log-${random_string.log_suffix.result}"
  retention_in_days = "90"

  tags = {
    Application = "magento"
    Terraform   = true
  }
}
