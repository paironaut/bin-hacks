#!/bin/sh

# fix-agent.sh
#
# Allows you to connect to your ssh-agent 
#
# source fix-agent 
# from a shell inside screen after you have reconnected
#
# From http://www.tolaris.com/2011/07/12/reconnecting-your-ssh-agent-to-a-detached-gnu-screen-session/
#
# Copyright (c) 2011-2013 Tyler J. Wager, Mike Matz and Remi Bergsma
# All rights reserved. Used by fair dealing / fair use.

export SSH_AUTH_SOCK=$(find /tmp/ssh-* -user $USER -name agent\* -printf '%T@ %p\n' 2>/dev/null | sort -k 1nr | sed 's/^[^ ]* //' | head -n 1)