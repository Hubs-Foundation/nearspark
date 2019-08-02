#!/usr/bin/env bash

# This command must be used to install a lambda-compatible version of sharp
env npm_config_arch=x64 npm_config_platform=linux npm_config_target=10.16.1 npm install --save sharp
