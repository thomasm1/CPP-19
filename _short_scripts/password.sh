#! /bin/bash
# password prompt

read -sp "Enter the Secret Code" secret

if [ "$secret" == "password" ]; then
	echo "Right on, Enter!"
else
	echo "Wrong Password"
fi
