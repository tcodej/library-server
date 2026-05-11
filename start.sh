#!/bin/bash
source ~/.nvm/nvm.sh
nvm use
pm2 start index.cjs
