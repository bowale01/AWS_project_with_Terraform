import csv
import boto3
import pymysql
import os

def get_secret():
    secret_name = "YOUR_SECRET_NAME"  # Replace with your secret name
    region_name = "YOUR_REGION"  # Replace with your region

    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    get_secret_value_response = client.get_secret_value(
        SecretId=secret_name
    )

    return get_secret_value_response['SecretString']

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bucket_name = os.environ['S3_BUCKET']
    object_list = s3.list_objects_v2(Bucket=bucket_name)['Contents']

    secret = get_secret()
    db_info = json.loads(secret)

    connection = pymysql.connect(
        host=db_info['host'],
        user=db_info['username'],
        password=db_info['password'],
        database=db_info['dbname']
    )

    for obj in object_list:
        file_key = obj['Key']
        response = s3.get_object(Bucket=bucket_name, Key=file_key)
        lines = response['Body'].read().decode('utf-8').split()
        csv_reader = csv.reader(lines)

        cursor = connection.cursor()

        for row in csv_reader:
            cursor.execute("INSERT INTO your_table (id, name, email) VALUES (%s, %s, %s)", row)

        connection.commit()

    cursor.close()
    connection.close()
