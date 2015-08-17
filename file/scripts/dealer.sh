#!/bin/bash
source ~/.bashrc;  
cd /data/website/dealer;
npm install && bower install && grunt build;
