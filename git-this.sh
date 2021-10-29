#!/bin/sh

echo "Enter the commit message:"
read MSG 
echo $MSG
git add .
git commit -m "$MSG"
git push origin master
