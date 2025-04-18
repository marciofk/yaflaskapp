#!/bin/bash

socat TCP-LISTEN:3909,fork TCP:127.0.0.1:3009 &

# Start the Meteor app
exec bash ./meteor-start.sh

