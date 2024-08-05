resource "aws_iam_role" "flink_role" {
  name = "${var.name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "kinesisanalytics.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "flink_policy" {
  role = aws_iam_role.flink_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:CreateLogGroup",
          "s3:GetObject",
          "s3:ListBucket",
          "kinesis:DescribeStream",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords"
        ]
        Resource = "*"
      }
    ]
  })
}
resource "aws_kinesisanalyticsv2_application" "example" {
  name                   = var.name
  runtime_environment    = var.runtime_environment
  service_execution_role = aws_iam_role.flink_role.arn

#   application_configuration {
#     application_code_configuration {
#       code_content {
#         s3_content_location {
#           bucket_arn = var.bucket_arn
#           file_key   = var.file_key
#         }
#       }

#       code_content_type = var.code_content_type
#     }

    # environment_properties {
    #   property_group {
    #     property_group_id = "PROPERTY-GROUP-1"

    #     property_map = {
    #       Key1 = "Value1"
    #     }
    #   }

    #   property_group {
    #     property_group_id = "PROPERTY-GROUP-2"

    #     property_map = {
    #       KeyA = "ValueA"
    #       KeyB = "ValueB"
    #     }
    #   }
    # }

    # flink_application_configuration {
    #   checkpoint_configuration {
    #     configuration_type = "DEFAULT"
    #   }

    #   monitoring_configuration {
    #     configuration_type = "CUSTOM"
    #     log_level          = "DEBUG"
    #     metrics_level      = "TASK"
    #   }

    #   parallelism_configuration {
    #     auto_scaling_enabled = true
    #     configuration_type   = "CUSTOM"
    #     parallelism          = 10
    #     parallelism_per_kpu  = 4
    #   }
    # }
  }
