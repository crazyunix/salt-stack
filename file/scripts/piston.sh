#!/bin/bash
source ~/.bashrc;  
cd /data/website/piston;
npm install && bower install && gulp build;
