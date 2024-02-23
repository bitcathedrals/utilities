#! /usr/bin/env bash

source aws.sh

case $1 in
  "upload")
    echo "uploading site to AWS S3 $BUCKET"
    aws s3 cp 'site/' "$BUCKET" --recursive --profile $PROFILE
    echo "you probably need to run \"invalidate\""
  ;;
  "list")
    aws cloudfront list-distributions --profile $PROFILE
  ;;
  "invalidate")
    shift
    aws cloudfront create-invalidation --distribution-id "$DISTID" --paths $1 --profile $PROFILE
  ;;
  "preview")
    (cd site && open -a Safari "gauge-security.html")
  ;;
  *)
    cat <<HELP
upload      = upload to AWS
list        = list cloudfront distributions
invalidate  = invalidate cloudfront, requires <invalidate paths> as an argument
review     = show the site as a file in Safari
HELP
  ;;
esac
