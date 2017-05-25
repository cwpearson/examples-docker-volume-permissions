
This is an example of how to handle docker writing to volumes as root. You can use these two scripts and an entrypoint to check who owns a volume, create a new user in the docker container with a matching uid/gid, and run the command as that user.
