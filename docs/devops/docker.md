# 安装mysql
参考：https://blog.csdn.net/weixin_43956484/article/details/116499061

# 日志操作logs 
- 查询容器全量日志路径 log-path
```bash
docker inspect 容器ID
```
- 时间段查询
```bash
docker logs --since="2023-04-28T00:00:00" --until "2023-04-28T12:00:00" 容器id >>file.log
```
- 关键词过滤
```bash
docker logs 容器id | grep -A 10 '处理失败'  # 打印匹配行的后10行
docker logs 容器id | grep -B 10 '处理失败'  # 打印匹配行的前10行
docker logs 容器id | grep -C 10 '处理失败'  # 打印匹配行的前后10行
```