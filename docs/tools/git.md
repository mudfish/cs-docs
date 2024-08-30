# 配置仓库用户名邮箱
- 全局方式
```bash
git config --global user.name "xxx"
git config --global user.email "xxx"
```
- 本地仓库方式
```bash
git config user.name "xxx"
git config user.email "xxx"
```

# 常见问题
## 解决 git：OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0
1. 取消现有http代理
```bash
git config --global --unset http.proxy
// 取消https代理 
git config --global --unset https.proxy
```
2. 指定自己的代理接口 
```bash
git config --global http.proxy http://127.0.0.1:33210
```
