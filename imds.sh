#!/bin/bash
 
# Set the metadata service URL

metadata_url="http://169.254.169.254/latest/api/token"
 
# Set the TTL (Time-To-Live) for the token in seconds (e.g., 21600 seconds = 6 hours)

ttl_seconds=21600
 
# Get the IMDSv2 token

token=$(curl -X PUT "$metadata_url" -H "X-aws-ec2-metadata-token-ttl-seconds: $ttl_seconds")
 
# Check if token retrieval was successful

if [[ -z "$token" ]]; then

  echo "Failed to retrieve the IMDSv2 token."

  exit 1

else

  echo "IMDSv2 Token retrieved successfully."

  echo "Token: $token"

fi
