#!/bin/bash

cpu_usage=$(top -l 1 | awk '/CPU usage/ {print $3}' | sed 's/%//')
echo $cpu_usage

