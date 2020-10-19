#!/bin/bash

ROOT=$(df -ah | grep sda1 | awk '{print $5}')
HOME=$(df -ah | grep sdb1 | awk '{print $5}')
BACKUP=$(df -ah | grep sdb2 | awk '{print $5}')

echo "   $ROOT   $HOME   $BACKUP"