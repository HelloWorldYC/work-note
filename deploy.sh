#!/usr/bin/env sh

var1=`date '+%Y-%m-%d %H:%M:%S'`

# 确保脚本抛出遇到的错误
set -e

echo '开始执行命令'

#发布到github上
echo '执行命令：git add -A'
git add -A
echo "git commit -m "
git commit -m "update notes on $var1"
echo '执行命令：git push -f git@github.com:HelloWorldYC/work-note.git master'
git push -f git@github.com:HelloWorldYC/work-note.git master