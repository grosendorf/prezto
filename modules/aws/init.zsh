# AWS Credentials
AWS_BASE=~/.aws
AWS_FILES=${AWS_BASE}/aws_files

aws_on() {
 export AWS_FULL=${1}
 export AWS_ACCOUNT=$(echo ${1} | awk -F "_" '{print $1}')
 export AWS_REGION=$(echo ${1} | awk -F "_" '{print $2}')
 export AWS_DEFAULT_REGION=${AWS_REGION}

 # AWS API
 export AWS_CREDENTIAL_FILE=${AWS_FILES}/credential-file_${AWS_ACCOUNT}

 #Chef Settings
 export CHEF_CREDENTIAL_FILE=~/.chef/config/chef-settings_${AWS_ACCOUNT}

 #Chef Server
 if [ -f $CHEF_CREDENTIAL_FILE ]; then
     export CHEF_SERVER_URL=`cat ${CHEF_CREDENTIAL_FILE} | grep chef_server_url | cut -d '=' -f 2`
     export CHEF_VALIDATOR_NAME=`cat ${CHEF_CREDENTIAL_FILE} | grep chef_validator_name | cut -d '=' -f 2`
     export CHEF_VALIDATOR_FILE=`cat ${CHEF_CREDENTIAL_FILE} | grep chef_validator_file | cut -d '=' -f 2`
     export CHEF_USERNAME=`cat ${CHEF_CREDENTIAL_FILE} | grep chef_username | cut -d '=' -f 2`
     export CHEF_REPO_DIR=`cat ${CHEF_CREDENTIAL_FILE} | grep chef_repo_dir | cut -d '=' -f 2`
     export CLIENT_KEY=`cat ${CHEF_CREDENTIAL_FILE} | grep chef_client_key | cut -d '=' -f 2`
 fi

 # EC2 API
 export AWS_ACCESS_KEY=`cat ${AWS_CREDENTIAL_FILE} |grep aws_access_key_id |cut -d '=' -f 2`
 export AWS_SECRET_KEY=`cat ${AWS_CREDENTIAL_FILE} |grep aws_secret_access_key |cut -d '=' -f 2`
 export AWS_REGION=$(echo ${1} | awk -F "_" '{print $2}')

 # Gem TF_VARs
 export TF_VAR_project_aws_access_key=`cat ${AWS_CREDENTIAL_FILE} |grep aws_access_key_id |cut -d '=' -f 2`
 export TF_VAR_project_aws_secret_key=`cat ${AWS_CREDENTIAL_FILE} |grep aws_secret_access_key |cut -d '=' -f 2`
 export TF_VAR_project_dns_aws_access_key=`cat ~/.aws/aws_files/credential-file_grid-prod | grep aws_access_key_id | cut -d '=' -f 2`
 export TF_VAR_project_dns_aws_secret_key=`cat ~/.aws/aws_files/credential-file_grid-prod | grep aws_secret_access_key | cut -d '=' -f 2`
 export AWS_REGION=$(echo ${1} | awk -F "_" '{print $2}')

 # BOTO
 export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY}
 export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_KEY}

 # WHISK
 export WHISK_CONFIG=${CHEF_REPO_DIR}/config/whisk-${AWS_FULL}.yml
}

aws_off() {
 unset AWS_FULL
 unset AWS_ACCOUNT
 unset AWS_CREDENTIAL_FILE
 unset AWS_ACCESS_KEY
 unset AWS_SECRET_KEY
 unset AWS_ACCESS_KEY_ID
 unset AWS_SECRET_ACCESS_KEY
}
