#! /usr/bin/env bash

source aws.sh

case $1 in
  "upload")
    echo "uploading site to AWS S3 $BUCKET"
    aws s3 cp "${2}/" "$BUCKET" --recursive --profile $PROFILE
  ;;
  *)
    cat <<HELP
upload      = upload <dir> to AWS
HELP
  ;;
esac
