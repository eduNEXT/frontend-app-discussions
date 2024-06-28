#!/bin/bash

log() {
  echo "=============================== $1 ==============================="
}

run_command() {
  echo "\$ $1"
  eval $1
}

log "Starting deployment script"
run_command "pwd"
run_command "ls -l"

# paragon
log "Processing paragon"
run_command "cd node_modules/@openedx/" || exit
log "Current directory: $(pwd)"
run_command "rm -rf paragon"
run_command "mkdir -p paragon"
run_command "cd paragon" || exit
log "Current directory: $(pwd)"
run_command "npm pack @openedx/paragon@23.0.0-alpha.2"
run_command "tar -xzf openedx-paragon-23.0.0-alpha.2.tgz --strip-components=1"
run_command "rm openedx-paragon-23.0.0-alpha.2.tgz"
run_command "cd ../../.." || exit
log "Current directory: $(pwd)"
run_command "ls -l"
# frontend-component-header
log "Processing frontend-component-header"
run_command "cd node_modules/@edx/ && ls" || exit
log "Current directory: $(pwd)"
run_command "rm -rf frontend-component-header"
run_command "git clone -b Peter_Kulko/support-design-tokens --single-branch https://github.com/PKulkoRaccoonGang/frontend-component-header.git"
run_command "cd frontend-component-header" || exit
log "Current directory: $(pwd)"
run_command "npm i --force && find ./node_modules/.bin/fedx-scripts"
run_command "npm run build"
run_command "cd ../../.." || exit
log "Current directory: $(pwd)"
run_command "ls -l"

# webpack
log "Running webpack"
run_command "fedx-scripts webpack"

log "Deployment script finished."
