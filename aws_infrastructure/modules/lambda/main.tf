resource "aws_iam_role" "lambda_role" {
  name = "${var.environment}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })

  tags = {
    Name = "${var.environment}-lambda-role"
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.environment}-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::${var.s3_bucket}",
          "arn:aws:s3:::${var.s3_bucket}/*",
        ],
      },
      {
        Action = [
          "secretsmanager:GetSecretValue",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:*",
      },
      {
        Action = [
          "rds:*",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_lambda_function" "import_csv" {
  filename         = "lambda/import_csv.zip"
  function_name    = "${var.environment}-import-csv"
  role             = aws_iam_role.lambda_role.arn
  handler          = "import_csv.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda/import_csv.zip")

  environment {
    variables = {
      S3_BUCKET = var.s3_bucket
    }
  }

  tags = {
    Name = "${var.environment}-import-csv"
  }
}

resource "aws_cloudwatch_event_rule" "schedule" {
  name        = "${var.environment}-schedule"
  description = "Schedule to trigger lambda every 10 minutes"
  schedule_expression = "rate(10 minutes)"
}

resource "aws_cloudwatch_event_target" "target" {
  rule = aws_cloudwatch_event_rule.schedule.name
  target_id = "import_csv"
  arn = aws_lambda_function.import_csv.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.import_csv.function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.schedule.arn
}
