#!/bin/bash

# Install python dependencies

# Install bioinformatic tools
for install_tool in $REPO_DIR/python/python_stack/*.sh
    do 
        source $install_tool
    done

