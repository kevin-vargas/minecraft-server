#!/bin/bash
JAR_FILE_NAME=server.jar

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
  exec java -server ${OPTS} -jar ${JAR_FILE_NAME} nogui
}

{
  move_to_directory &&
  get_jar_file &&
  accept_eula &&
  add_options &&
  exec_server
}