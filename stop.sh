#!/bin/bash
MESSAGE="Server is stopping!"
INTERVAL=5
PASS=palic

mcrcon -p $PASS -w $INTERVAL "say ${MESSAGE}" save-all stop