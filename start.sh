#!/bin/bash
source ~/.nvm/nvm.sh
nvm use
~/.nvm/versions/node/v20.19.2/bin/pm2 start index.cjs
