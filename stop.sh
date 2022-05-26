#!/bin/bash
MSG="Server is stopping!"
INTERVAL=5
PASS=palic

mcrcon -p $PASS -w $INTERVAL "say ${MSG}" save-all stop