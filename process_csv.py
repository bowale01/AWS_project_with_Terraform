#Programming Task

#Step 1: Create a Python Script for Handling CSV
#Create a Python script process_csv.py to read a CSV file from S3 and import it into the RDS database:

import boto3
import csv
import pymysql
import os

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    secrets_client = boto3.client('secretsmanager')
    
    bucket_name = os.environ['BUCKET_NAME']
    file_name = os.environ['FILE_NAME']
    secret_name = os.environ['SECRET_NAME']
    
    # Retrieve database credentials from Secrets Manager
    secret_response = secrets_client.get_secret_value(SecretId=secret_name)
    secret = json.loads(secret_response['SecretString'])
    
    # Connect to the database
    connection = pymysql.connect(
        host=secret['host'],
        user=secret['username'],
        password=secret['password'],
        database=secret['dbname']
    )
    
    cursor = connection.cursor()
    
    # Download the CSV file from S3
    s3_client.download_file(bucket_name, file_name, '/tmp/' + file_name)
    
    # Read and insert data from the CSV file
    with open('/tmp/' + file_name, 'r') as csvfile:
        csv_reader = csv.reader(csvfile)
        for row in csv_reader:
            cursor.execute("INSERT INTO my_table (column1, column2) VALUES (%s, %s)", row)
    
    connection.commit()
    cursor.close()
    connection.close()
