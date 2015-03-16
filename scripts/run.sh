#!/bin/bash

useradd -m riakcl
echo "riakcl:$PASS" | chpasswd 
