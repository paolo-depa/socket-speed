#!/bin/bash

# This script is a client loop for sending messages to an abstract socket server.
# 
# Usage:
#   ./ans_client_loop.sh <client_id>
#
# Arguments:
#   <client_id> : A unique identifier for the client instance.
#
# Description:
#   The script continuously sends messages to the server using the ans_client.sh script.
#   Each message contains the client ID and a counter value that increments with each iteration.
#   The script runs indefinitely until manually stopped.
#
# Environment Variables:
#   ANS_CLIENT_COMMAND : The command to execute the client script (default: ./ans_client.sh).
#   ABSTRACT_SOCKET    : The name of the abstract socket server (default: ans_server).
#
# Example:
#   ./ans_client_loop.sh 1
#   This will start the client with ID 1 and begin sending messages to the server.

ANS_CLIENT_COMMAND="./ans_client.sh"
ABSTRACT_SOCKET="ans_server"

ID=$1
if [ -z $ID ]; then
    echo "Usage: $0 <client_id>"
    exit 1
fi

echo "$(date): Starting client $ID"

COUNTER=0
while true; do
    COUNTER=$((COUNTER+1))
    MESSAGE="$ID-$COUNTER"
    $ANS_CLIENT_COMMAND "$MESSAGE"
done


