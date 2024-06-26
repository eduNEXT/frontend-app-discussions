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

# frontend-platform
log "Processing frontend-platform"
run_command "cd node_modules/@edx/" || exit
log "Current directory: $(pwd)"
run_command "rm -rf frontend-platform"
run_command "git clone -b dcoa/design-tokens-support --single-branch https://github.com/eduNEXT/frontend-platform.git"
run_command "cd frontend-platform" || exit
log "Current directory: $(pwd)"
run_command "npm ci"
run_command "npm run build"
run_command "cp -a dist/. ../frontend-platform/"
run_command "cd .." || exit
log "Current directory: $(pwd)"
run_command "find frontend-platform -mindepth 1 -maxdepth 1 ! -name 'dist' -delete"
run_command "mv frontend-platform/dist/* frontend-platform/"
run_command "rm -rf frontend-platform/dist"
run_command "cd ../.." || exit
log "Current directory: $(pwd)"

# frontend-build
log "Processing frontend-build"
run_command "cd node_modules/@openedx/" || exit
log "Current directory: $(pwd)"
run_command "rm -rf frontend-build"
run_command "git clone -b dcoa/design-tokens-support --single-branch https://github.com/eduNEXT/frontend-build.git"
run_command "cd frontend-build" || exit
log "Current directory: $(pwd)"
run_command "npm ci"
run_command "cd ../../.." || exit
log "Current directory: $(pwd)"

# paragon
log "Processing paragon"
run_command "ls -l"
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

# frontend-component-header
log "Processing frontend-component-header"
run_command "cd node_modules/@edx/" || exit
log "Current directory: $(pwd)"
run_command "rm -rf frontend-component-header"
run_command "git clone -b Peter_Kulko/support-design-tokens --single-branch https://github.com/PKulkoRaccoonGang/frontend-component-header.git"
run_command "cd frontend-component-header" || exit
log "Current directory: $(pwd)"
run_command "npm i --force"
run_command "npm run build"
run_command "cd ../../.." || exit
log "Current directory: $(pwd)"

# webpack
log "Running webpack"
run_command "fedx-scripts webpack"

log "Deployment script finished."
