#!/bin/bash

# prompt-vars.sh
#
# source prompt-vars.sh
# to customize the prompt variables in your Bash shell

# Adapted from various prompts by David Corking, 2013

source $HOME/bin-hacks/git-prompt.sh

export PROMPT_COMMAND='__git_ps1 "${debian_chroot:+($debian_chroot)}\u@\h:\w" "\\\$ "'
