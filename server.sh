#!/bin/bash
JAR_FILE_NAME=server.jar
DEFAULT_FLAGS="-Xms10G -Xmx10G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
move_to_directory(){
    local DIRECTORY=build
    mkdir -p $DIRECTORY &&
    cd $DIRECTORY
}

get_jar_file(){
  if [ ${VERSION} = latest ]
  then
    local BASE_URL=https://papermc.io/api/v2/projects/paper
    local MINECRAFT_VERSION=$(wget -qO - $URL | jq -r '.versions[-1]')
    local PAPER_VERSION=$(wget -qO - ${URL}/versions/${MINECRAFT_VERSION} | jq '.builds[-1]')
    local JAR_URL=${BASE_URL}/builds/${PAPER_VERSION}/downloads/paper-${MINECRAFT_VERSION}-${PAPER_VERSION}.jar
    rm -f $JAR_FILE_NAME
    wget ${URL} -O ${JAR_FILE_NAME}
  if
}

accept_eula(){
  if [ ! -e eula.txt ]
  then
    java -jar $JAR_FILE_NAME
    sed -i 's/false/true/g' eula.txt
  fi
}

add_optionals(){
  if [ ! -z "${RAM}" ]
  then
    OPTS="-Xms${RAM} -Xmx${RAM} ${OPTS}"
  fi
}

exec_server(){
  exec java -server ${DEFAULT_FLAGS} ${OPTS} -jar ${JAR_FILE_NAME} nogui
}

{
  move_to_directory &&
  get_jar_file &&
  accept_eula &&
  add_options &&
  exec_server
}