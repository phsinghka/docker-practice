#!/bin/sh

# Print the environment variable
echo "MY_VAR is set to: $MY_VAR"

# Print the command
echo "Running command: $@"

# Execute the command
exec "$@"

