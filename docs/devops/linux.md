
# 防火墙

## iptables
* [iptables](https://github.com/hustcc/iptables)

# 磁盘操作
# 网络操作
# 

# 常用命令
## zip压缩
```bash
zip -r file.zip file1 file2
# 解压覆盖
unzip -o file.zip
```
## tar压缩解压
## 文件处理
- 将文件夹及其子文件夹下指定类型文件复制到其他文件夹
```bash
find /home/aaa -type f -name "*.png" -exec cp \{\} /home/bbb \;
```
# 问题处理
## 文件名最大长度
255字符，86汉字