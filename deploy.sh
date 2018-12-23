#!/bin/bash

rm -frv mdapi/
sfdx force:source:convert -d mdapi/ --packagename $2
sfdx force:mdapi:deploy -d mdapi/ -u $1 -l RunLocalTests -w 5
