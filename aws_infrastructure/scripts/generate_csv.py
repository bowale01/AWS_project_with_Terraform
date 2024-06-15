import boto3
import csv
import random
import string
import time

s3 = boto3.client('s3')
bucket_name = 'YOUR_BUCKET_NAME'  # Replace with your bucket name

def generate_csv():
    timestamp = int(time.time())
    filename = f'/tmp/data_{timestamp}.csv'
    with open(filename, 'w', newline='') as csvfile:
        fieldnames = ['id', 'name', 'email']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for _ in range(100):  # Generate 100 random records
            writer.writerow({
                'id': random.randint(1, 1000),
                'name': ''.join(random.choices(string.ascii_lowercase, k=10)),
                'email': ''.join(random.choices(string.ascii_lowercase, k=10)) + '@example.com'
            })
    s3.upload_file(filename, bucket_name, f'data_{timestamp}.csv')
    print(f'Uploaded {filename} to s3://{bucket_name}/data_{timestamp}.csv')

if __name__ == "__main__":
    generate_csv()
