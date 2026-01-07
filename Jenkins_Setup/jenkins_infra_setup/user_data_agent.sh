#!/bin/bash

# Install Java on Agent Nodes
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y 
java -version