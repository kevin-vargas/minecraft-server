#!/bin/bash

JAR_FILE_NAME=server.jar
DEFAULT_FLAGS="-Xms4G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
RUN="java -server ${DEFAULT_FLAGS} -jar ${JAR_FILE_NAME} nogui"
#RUN="go run main.go"

move_to_directory(){
    local DIRECTORY=build
    cd $DIRECTORY
}

exec_server(){
  local SESSION="minecraft"
  echo "Getting previus session..."
  if ! screen -r $SESSION ;
  then
    echo "Starting in a deteched screen named ${SESSION}."
    screen -mS $SESSION $RUN
    echo "For use the session run: screen -r ${SESSION}"
  fi
}

{
    move_to_directory &&
    exec_server
}