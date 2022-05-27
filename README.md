# Minecraft Scripts

Description: the objective of this project is to be able to run a minecraft server quickly. Using a container or in the traditional way.

## Running the scripts

**Install:**

```shell
    ./install.sh
```

**Start server in new screen:**

```shell
    ./start.sh
```

To exit the screen session press: ctrl+A and then D

**Stop server:**

```shell
    ./stop.sh
```

## Run in container

**Example:**

```shell
    docker build -t minecraft-server . &&
    docker run minecraft-server
```
