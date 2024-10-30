#!/bin/bash
# This script sends a message to an abstract socket server using socat.
# 
# Usage:
#   ./ans_client.sh <message>
#
# Arguments:
#   <message>  The message to be sent to the abstract socket server.
#
# Environment Variables:
#   ABSTRACT_SOCKET  The name of the abstract socket server. Default is "ans_server".
#
# Example:
#   ./ans_client.sh "Hello, Server!"
#
# If no message is provided, the script will display usage information and exit.


ABSTRACT_SOCKET="ans_server"
MESSAGE=$1
if  [ -z $MESSAGE ]; then
    echo "Usage: $0 <message>"
    exit 1
fi

SOCAT=$(which socat)
if [ -z $SOCAT ]; then
    echo "socat not found"
    exit 1
fi

LOGFILE="/tmp/ans_client.log"

echo $MESSAGE | $SOCAT - ABSTRACT-CONNECT:$ABSTRACT_SOCKET

if [ $? -ne 0 ]; then
    echo "$(date): Failed to send message: $MESSAGE" >> $LOGFILE
fi