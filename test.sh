#!/bin/bash

# some commands must be executable
rsync --version | head -n 1 || exit 1
php -v || exit 1
composer --version || exit 1
dep --version || exit 1
composer global show deployer/deployer 2>&1 | head -n 5 | tail -n 1
composer global show deployer/recipes 2>&1 | head -n 5 | tail -n 1
