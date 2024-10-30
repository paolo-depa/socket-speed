#!/bin/bash

# This script sets up a server using socat to listen on an abstract Unix domain socket.
# 
# Variables:
# ABSTRACT_SOCKET: The name of the abstract socket to listen on.
# SOCKET_OPTIONS: Options to pass to socat for the socket (e.g., reuseaddr, fork).
# DEBUG: Debug mode flag (0 for off, 1 for on).
# 
# The script checks if socat is installed and exits if not found.
# It constructs the socat command with the specified options and executes it.
# 
# Usage:
# 1. Ensure socat is installed on your system.
# 2. Run the script to start the server.
# 3. The server will listen on the specified abstract socket and output to STDOUT.

ABSTRACT_SOCKET="ans_server"
SOCKET_OPTIONS=",reuseaddr,fork"
DEBUG=0

SOCAT=$(which socat)
if [ -z $SOCAT ]; then
    echo "socat not found"
    exit 1
fi

# -s     By default, socat terminates when an error occurred to prevent the process from running when some option could not be applied. With this option, socat is sloppy with errors and tries to continue. Even with this option,  socat will exit on fatals, and will abort connection attempts when security checks failed.
# -u     Uses unidirectional mode. The first address is only used for reading, and the second address - !!STDOUT!! - is only used for writing.

SOCAT+=" -s -u"

if [ $DEBUG -eq 1 ]; then
    SOCAT+=" -d$DEBUG"
fi

SOCAT+=" ABSTRACT-LISTEN:$ABSTRACT_SOCKET"
if [ ! -z $SOCKET_OPTIONS ]; then
    SOCAT+=$SOCKET_OPTIONS
fi

SOCAT+=" STDOUT"

echo "Starting abstract socket server on @$ABSTRACT_SOCKET"
exec $SOCAT