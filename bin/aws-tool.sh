#! /usr/bin/env bash


 #
 # AWS commands
 #
case $1 in
  "creds")
    shift

    AWS_ROLE=$1

    test -f aws.sh && source aws.sh

    printf >${AWS_ROLE}.sh "export AWS_ACCESS_KEY_ID=\"%s\" AWS_SECRET_ACCESS_KEY=\"%s\" AWS_SESSION_TOKEN=\"%s\"" \
                $(aws sts assume-role \
                  --role-arn $AWS_ROLE \
                  --role-session-name pythonsh-cli-creds \
                  --profile $PROFILE \
                  --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
                  --output text)
  ;;
  "aws")
    shift

    test -f aws.sh && source aws.sh

    role=""

    if [[ -n $1 ]]
    then
      if echo "$1" | grep -E '^role='
      then
        role=$(echo $1 | cut -d '=' -f 2)

        if [[ -f ${role}.sh ]]
        then
          source ${role}.sh
          shift
        else
          echo "role file: ${role}.sh cound not be found"
          exit 1
        fi
      fi
    fi

    aws $@ --profile $PROFILE --output json
    ;;
  *)
    cat >/dev/stderr <<HELP
aws-tool

a tool for constructing awscli commmands

  creds    = get the aws credentials for a non-root role
  aws      = execute a command as a non root user
HELP
  ;;
esac
