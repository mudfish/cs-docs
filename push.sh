message=$1

# 更新 master
git add .
git commit -m "$message"
git push -f https://github.com/mudfish/cs-docs.git main