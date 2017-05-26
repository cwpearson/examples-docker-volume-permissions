
## Problem

When a program is run in Docker, it is run as the user in that container.
This may not match the user on the host system who runs the container.
If the program creates files in a volume, this can cause permission problems on the host.

## Solution

A wrapper script checks the `USER_DIR` environment variable.
It stats that dir, and creates a user in the container that matches the `uid`/`gid` of that directory.
It then runs the container command as that user.
If the container writes a file into a volume mapped to something that matches `USER_DIR`, the owner of that directory on the host will be able to control those files after execution.

    #! /bin/bash
    
    CAFFE_ROOT=/raid/home/pearson/caffe-1.0
    
    nvidia-docker run \
     -v $CAFFE_ROOT:/caffe \
     -w /caffe \
     -e USER_DIR=/caffe \
     -it caffe-deps /bin/bash -c 'pwd && ls && mkdir -p build && cd build && pwd && cmake .. && nice -n20 make -j 16'
