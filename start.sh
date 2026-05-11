#!/bin/bash
source ~/.nvm/nvm.sh
nvm use
pm2 start index.cjs
#~/.nvm/versions/node/v20.19.2/bin/pm2 start index.cjs
