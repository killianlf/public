#!/bin/bash

metadata_url="http://169.254.169.254/latest/api/token"
metadata_base_url="http://169.254.169.254/latest/meta-data"
output_file="/tmp/instance_metadata.txt"
ttl_seconds=21600

echo "Retrieving IMDSv2 token..."
token=$(curl -s -X PUT "$metadata_url" -H "X-aws-ec2-metadata-token-ttl-seconds: $ttl_seconds")

if [[ -z "$token" ]]; then
  echo "Failed to retrieve the IMDSv2 token."
  exit 1
fi
 
echo "IMDSv2 token retrieved successfully."

echo "Retrieving instance metadata..."

> "$output_file"

echo "Writing instance metadata to $output_file..."

metadata_fields=(
  "instance-id"
  "ami-id"
  "hostname"
  "iam/security-credentials/"
  "placement/availability-zone"
  "instance-type"
)
 
# Loop through each metadata field and fetch the data
for field in "${metadata_fields[@]}"; do
  echo "Fetching $field..."
  data=$(curl -s -H "X-aws-ec2-metadata-token: $token" "$metadata_base_url/$field")
  echo "$field: $data" >> "$output_file"
done
 
# Notify that the data has been saved
echo "Instance metadata has been saved to $output_file."
