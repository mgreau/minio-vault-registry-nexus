#!/bin/bash

set -uo pipefail

minio_url=http://minio:9000

# Create buckets if it doesn't exist yet
for BUCKET in snapshots staging artifacts
do
  aws --endpoint-url ${minio_url} s3 ls s3://${BUCKET}

  if [[ $? -eq 0 ]]
  then
     echo "Bucket ${BUCKET} already exists."
  else
    echo "Creating ${BUCKET}..."
    aws --endpoint-url ${minio_url} s3 mb s3://${BUCKET}  
  fi
done

exit 0