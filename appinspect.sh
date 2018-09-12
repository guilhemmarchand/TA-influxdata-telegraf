#!/bin/bash

splunk-appinspect inspect `ls *.tgz | head -1` --mode precert --included-tags cloud
