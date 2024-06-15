#Step 2: Set Up Lambda Function
#Create a Lambda function using Terraform:

resource "aws_lambda_function" "csv_processor" {
  filename         = "process_csv.zip"
  function_name    = "${var.environment}-csv-processor"
  role             = aws_iam_role.lambda_role.arn
  handler          = "process_csv.lambda_handler"
  runtime          = "python3.8"
  timeout          = 60

  environment {
    variables = {
      BUCKET_NAME = var.s3_bucket
      FILE_NAME   = "data.csv"
      SECRET_NAME = var.db_secret
    }
  }

  source_code_hash = filebase64sha256("process_csv.zip")
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.environment}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_s3_policy" {
  name = "${var.environment}-lambda-s3-policy"
  
