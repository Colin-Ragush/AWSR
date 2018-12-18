#!/bin/bash

# user settings and secrets
# customize and rename to `setup_user.sh`
# overwrites `secrets_default.sh`, `settings_default.sh`, `setup_auto.sh`
#!/bin/bash

# default local and AWS secrets, placeholders only - safe to commit to git
# be sure that all values are defined in setup_auto.sh or in setup_user.sh

#!/bin/bash

# default local and AWS settings, excluding secrets - safe to commit to git
# be sure that all values are defined in setup_auto.sh or in setup_user.sh


# Project ----------------------------------------------------------------------

# name of the project root directory, error if mismatch
# use only letters, dashes, and digits, e.g. aws-lambda-r
PRJ_NAME="AWSR"

# Name of the current Git branch, error if mismatch
PRJ_BRANCH="$AWSR"


# AWS --------------------------------------------------------------------------

# We do not set AWS_PROFILE to prevent undesired interactions with AWS CLI
# profile to use for AWS as in `aws $AWS_PRFL s3 ls`
AWS_PRFL="--profile default"

# We do not set AWS_DEFAULT_REGION to prevent undesired interactions with AWS CLI
# AWS ec2, s3, lambda and API gateway region. us-east-1 is US East (N. Virginia).
AWS_REGION="us-east-2"


# AWS IAM ----------------------------------------------------------------------

# The AWS name the IAM Role associated with the Lambda function execution
# AWS > IAM > Roles > (if missing: Create new role)
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
IAM_LAMBDA_ROLE_NAME="$MISSING"

# Obtained automatically from IAM_LAMBDA_ROLE_NAME, listed here for reference
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
IAM_LAMBDA_ROLE_ARN="$MISSING"

# The name of the file containing Lambda trust policy
# We allow Lambda to assume this IAM (execution) role
# Using a relative path to avoid drive letter issues in AWS CLI on windows
IAM_LAMBDA_ROLE_TRUST_FILE="settings/lambda_role_trust.json"

# The name of the file containing IAM role policy for Lambda execution
# We allow Lambda to write to logs
# Add other access, as needed, for Lambda (e.g. access S3)
# Using a relative path to avoid drive letter issues in AWS CLI on windows
IAM_LAMBDA_ROLE_POLICY_FILE="settings/lambda_role_policy.json"


# AWS EC2 ----------------------------------------------------------------------

# The ID of the Amazon Machine Image which is the template for the EC2 instance.
# Find the most recent AMI used by AWS Lambda for your region
# https://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html
EC2_DEFAULT_AMI_ID="ami-4fffc834"

# The ID of the cache AMI ($EC2_AMI_ID + update + python + R)
# If present this ID will be used instead of $EC2_AMI_ID
# AMI kept private because it is project specific (and it may contain your keys)
# Added automatically in setup_auto.sh by 
EC2_CUSTOM_AMI_ID="$MISSING"

# The type/size of the instance 
# AWS > EC2 > instance-types
EC2_INSTANCE_TYPE="t2.micro"

# For Amazon Linux VMs the default username is 'ec2-user'.
EC2_USERNAME="ec2-user"

# Maximum number of attempts to check on the EC2. Each attempt takes 5 seconds.
EC2_MAX_TESTS=20


## AWS Lambda Authorizer -------------------------------------------------------

# The AWS name of the Lambda Authorizer function
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
LAMBDA_AUTHORIZER_NAME="$MISSING"

# Obtained automatically from LAMBDA_AUTHORIZER_NAME, listed here for reference
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
LAMBDA_AUTHORIZER_ARN="$MISSING"

# The file containing the Lambda Authorizer function
# Using a relative path to avoid drive letter issues in AWS CLI on windows
LAMBDA_AUTHORIZER_FILE="settings/lambda_authorizer.js"


# AWS API Gateway --------------------------------------------------------------

# Use / deploy to an Alias Resource?
API_ALIAS_RESOURCE_USE="false"

# A stage is a unique identifier for a version of a deployed API
# Choices (suggested): alpha, beta, prod
API_STAGE="alpha"

# The type of request API is expecting 
API_HTTP_METHOD="GET"

# The type of API gateway authorization. In order to secure API calls 
# Use "NONE" not to use any Authorizer
# Use "CUSTOM" to use the Lambda Authorizer
API_AUTHORIZATION_TYPE="NONE"


## AWS Lambda ------------------------------------------------------------------

# The name of the python file which contains the lambda function (w/o extension)
# AWS > Lambda > Functions > Configuration
LAMBDA_PYTHON_HANDLER="$MISSING"
LAMBDA_PYTHON_HANDLER_GET="lambda_get"
LAMBDA_PYTHON_HANDLER_POST="lambda_post"

# The name of the handler function within the LAMBDA_PYTHON_HANDLER 
# AWS > Lambda > Functions > Configuration
LAMBDA_HANDLER_FUNCTION="$MISSING"
LAMBDA_HANDLER_FUNCTION_GET="handler_get"
LAMBDA_HANDLER_FUNCTION_POST="handler_post"

# The chosen runtime for lambda function (AWS>LAMBDA>RUNTIME)
# AWS > Lambda > Functions > Configuration
LAMBDA_RUNTIME="python3.6"

# The time limit (in seconds) for the lambda function to run
# AWS > Lambda > Functions > Configuration
LAMBDA_TIMEOUT="59"

# The amount of memory allocated to the lambda function (max memory --> max CPU)
# AWS > Lambda > Functions > Configuration
LAMBDA_MEMORY_SIZE="3008"


# R ----------------------------------------------------------------------------

# List of R packages to be installed and used by the Lambda function
# do not use commas or quotes, leave spaces before and after each package name
R_PACKAGES=( jsonlite )

# The request id sent to R, for example purposes only
# For new applications, please update all tests that use curl and REQUEST_ID
REQUEST_ID=1111


# testing ----------------------------------------------------------------------

# Option for cp command.
# Choices: "--verbose" (show the copied files) or " " (copy without showing) 
CP_VERBOSE=" "

# set to "skip_commit" to skip commit (unsafe!)
DEBUG="false"
# AWS IAM ----------------------------------------------------------------------

# AWS Access Key ID (simplest setup: create a deployment user/key)
# AWS > IAM > Users > Add user
# (we use the IAM_ prefix to avoid exporting it locally by mistake)
# Might be different than what is in AWS profile; will be used on EC2
# If you use the came access on both local and EC2, copy from AWS CLI profile
IAM_ACCESS_KEY_ID="AKIAIXMNUXJD3XFWVBXQ"

# Secret Access Key corresponding to Access Key ID
# Only available when the user has been created
# If you use the came access on both local and EC2, copy from AWS CLI profile
IAM_SECRET_ACCESS_KEY="MyYPY5if/wdXBmnKolwCjmS+cVbIHfYrYr3piuZO"


# AWS EC2 ----------------------------------------------------------------------

# The name (as known to AWS) of the SSH key used to connect to an EC2 instance securely
# A file with the same name (and with extension .pem) should have been downloaded 
# from AWS to the dir ~/.ssh/
# AWS > EC2 > Network and security > Key Pairs > Create Key Pair
EC2_KEY_NAME="RinAWS.pem"

# The dir where the above key file is located
EC2_KEY_FILE="~/.aws/${EC2_KEY_NAME}.pem"

# AWS > VPC > Subnets > (optional: Create Subnet)
# If no VPC setup, see AWS > VPC > Your VPCs > Create VPC
EC2_SUBNET_ID="subnet-5bef8921"

# The security group id to which the new instance will belong
# AWS > EC2 > Network a& Security > Security Groups > Create Security Group
EC2_SECURITY_GROUP_IDS="sg-$MISSING"


## AWS S3 ----------------------------------------------------------------------

# The name of the S3 bucket in which the deployment package will be uploaded
# AWS > S3 > (optional: Create bucket & folder)
S3_BUCKET="$MISSING"


# AWS API Gateway --------------------------------------------------------------

# The AWS name of the API Gateway on which the http calls are made 
# AWS > API Gateway > API's
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_GATEWAY_NAME="$MISSING"

# Obtained automatically from API_GATEWAY_NAME, listed here for reference
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_GATEWAY_ID="$MISSING"

# The AWS name of the resource under the API Gateway Root Resource
# AWS > API Gateway > APIs > [API NAME] > Resources
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_RESOURCE_NAME="$MISSING"

# Obtained automatically from API_RESOURCE_NAME, listed here for reference
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_RESOURCE_ID="$MISSING"

# The AWS name of the Alias resource (e.g. url of the latest app API version)
# Ignored if $API_ALIAS_RESOURCE == "false"
# AWS > API Gateway > APIs > [API NAME] > Resources
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_ALIAS_RESOURCE_NAME="$MISSING"

# Obtained automatically from API_ALIAS_RESOURCE_NAME, listed here for reference
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_ALIAS_RESOURCE_ID="$MISSING"

# The AWS name of API custom authorizer (that calls Lambda Authorizer)
# AWS > API Gateway > APIs > [API NAME] > Authorizers
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_AUTHORIZER_NAME="$MISSING"

# Obtained automatically from API_AUTHORIZER_NAME, listed here for reference
# Added in `setup_auto.sh` by `24_setup_lambda.sh`
API_AUTHORIZER_ID="$MISSING"

# Authorization token for the Lambda Authorizer function 
# Needed to make API requests (to restrict access to the main Lambda function)
# Must match API_TOKEN in lambda_authorizer.js
# AWS> LAMBDA > see code within the lambda authorization function
API_TOKEN="aws-lambda-r-api-token"


## AWS Lambda ------------------------------------------------------------------

# The AWS name of the Lambda function (in Python, calling R)
# If missing, "${PRJ_NAME}-${PRJ_BRANCH}-${API_STAGE}-${API_RESOURCE_NAME}"
# AWS > Lambda > Functions
LAMBDA_FUNCTION_NAME="$MISSING"
