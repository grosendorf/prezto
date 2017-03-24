# AWS Credentials
AWS_BASE=~/.aws
AWS_FILES=${AWS_BASE}/aws_files
AWS_REGION=us-east-1
AWS_DEFAULT_REGION=us-east-1

aws_on() {
 export AWS_FULL=${1}
 export AWS_PROFILE_NAME=$(echo ${1} | awk -F "_" '{print $1}')
 export AWS_REGION_NAME=$(echo ${1} | awk -F "_" '{print $2}')

 if [ ! -z $AWS_REGION_NAME ]; then
   export AWS_REGION=${AWS_REGION_NAME}
   export AWS_DEFAULT_REGION=${AWS_REGION_NAME}
 fi

 if aws configure list --profile ${AWS_PROFILE_NAME} &> /dev/null; then
   export AWS_PROFILE=${AWS_PROFILE_NAME}
 else
   echo "Profile not found: ${AWS_PROFILE_NAME}"
   aws_off
 fi
 }

aws_off() {
 unset AWS_FULL
 unset AWS_PROFILE
 unset AWS_PROFILE_NAME
 unset AWS_REGION
 unset AWS_DEFAULT_REGION
}
