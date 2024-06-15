# AWS_project_with_Terraform


Goal
To set up a small infrastructure in AWS ready to host a theoretical application.
This infrastructure should be created using Terraform. There should be sufficient
documentation at the end of the challenge so that someone who is unfamiliar
with the challenge will be able to re-launch the infrastructure with minimal
issues.
Please see below for individual requirements. The candidate is expected to follow
all the requirements. In case they think there is a strong reason to make changes
to them, they are expected to describe and explain their choice in the
documentation.
Please make sure the size of the instances for the Compute and RDS setup is not
bigger than necessary.
Duration
The candidate is expected to complete the assignment 7 days after receiving the
documentation and credentials
AWS Access
The candidate will be given console and programmatic access to a dedicated
AWS account. The candidate should create the infrastructure in Ireland
(eu-west-1) region of AWS. The user name will be their first name underscore
challenge (e.g. bob_challenge). The credentials will be supplied by email, and the
candidate will be expected to change the password when they log in for the first
time. The resources will be retained until we review the challenge.
Infrastructure task
● Using Terraform, provision a small infrastructure consisting of

○ 1 VPC with private and public subnets using at least 2 AZ

○ 1 small ec2 instance to host a theoretical application. The instance

should be only accessible from the internet on ssh and http(s) ports

○ 1 RDS cluster (Aurora MySQL), that should be only reachable from
the internal network

○ 1 S3 bucket configured for storing files containing sensitive data
● All additional resources (IAM roles / policies, security groups, etc) should be
in terraform

● The terraform code should be easily scalable and highly configurable

● The terraform state file should be stored in an S3 bucket

● 2 different configurations should be provided, to apply the code to 2
different environments (staging and production)

Programming task
On the infrastructure created with terraform, enable a script that reads a CSV file
stored in the S3 bucket and exports the content into a database table
● The script can run as a cron job on the EC2 instance or as a lambda
● The script should fetch the database credentials from secrets manager
● It should be assumed that the data are highly sensitive
● The content of the CSV file(s) changes frequently
● A script to populate the CSV file(s) is provided with random data. It can be
adjusted as the candidate sees necessary and should be setup to

○ store the generated file into the S3 bucket

○ run every 10 minutes as a cron job or as a lambda

● The sql statement for creating the Database and DB table is provided

Documentation
At the end of the challenge the candidate is expected to provide documentation
explaining their set up and the steps to relaunch the infrastructure via
infrastructure as code. This can be done via a visual chart, a readme doc outlining
what their setup is, or both.
The candidate is expected to pay as much attention to the quality of the
documentation as to the quality of the code.
Some of the things expected from the doc are:

● The setup in a simple, concise matter

● Steps to relaunch the infrastructure (assume someone who is unfamiliar
with the challenge)

● Assumptions made
When finished
When the challenge is done, the candidate should commit their code to our git
repo which will be setup beforehand. The documentation should be included in
the git repo as well.
Once finished, please let the interviewer know that the challenge is finished. We
will review it and schedule a follow up interview to speak about the challenge.
Support and Questions
