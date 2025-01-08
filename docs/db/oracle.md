# 常用SQL
### 查询表空间信息
```sql
SELECT 
    TABLESPACE_NAME,
    STATUS,
    CONTENTS,
    EXTENT_MANAGEMENT,
    SEGMENT_SPACE_MANAGEMENT
FROM 
    DBA_TABLESPACES;
```

```sql
SELECT 
    TABLESPACE_NAME,
    ROUND(SUM(BYTES) / (1024 * 1024), 2) AS TOTAL_MB,
    ROUND(SUM(BYTES) / (1024 * 1024 * 1024), 2) AS TOTAL_GB
FROM 
    DBA_DATA_FILES
GROUP BY 
    TABLESPACE_NAME;
```

## 查询数据文件信息
```sql
SELECT 
    FILE_NAME,
    TABLESPACE_NAME,
    BYTES / (1024 * 1024) AS SIZE_MB,
    BYTES / (1024 * 1024 * 1024) AS SIZE_GB,
    AUTOEXTENSIBLE,
    MAXBYTES / (1024 * 1024) AS MAXSIZE_MB,
    MAXBYTES / (1024 * 1024 * 1024) AS MAXSIZE_GB
FROM 
    DBA_DATA_FILES;
```
### 查询表空间的使用和剩余空间
```sql
SELECT 
    TABLESPACE_NAME,
    ROUND(SUM(BYTES) / (1024 * 1024), 2) AS FREE_MB,
    ROUND(SUM(BYTES) / (1024 * 1024 * 1024), 2) AS FREE_GB
FROM 
    DBA_FREE_SPACE
GROUP BY 
    TABLESPACE_NAME;
```

### 查询表空间的占用和可用空间
```sql
SELECT 
    df.TABLESPACE_NAME,
    ROUND(df.TOTAL_SIZE_MB, 2) AS TOTAL_SIZE_MB,
    ROUND(nvl(fs.FREE_SIZE_MB, 0), 2) AS FREE_SIZE_MB,
    ROUND(df.TOTAL_SIZE_MB - nvl(fs.FREE_SIZE_MB, 0), 2) AS USED_SIZE_MB,
    ROUND((df.TOTAL_SIZE_MB - nvl(fs.FREE_SIZE_MB, 0)) / df.TOTAL_SIZE_MB * 100, 2) AS USED_PERCENT
FROM 
    (SELECT 
        TABLESPACE_NAME, 
        SUM(BYTES) / (1024 * 1024) AS TOTAL_SIZE_MB
     FROM 
        DBA_DATA_FILES
     GROUP BY 
        TABLESPACE_NAME) df
LEFT JOIN 
    (SELECT 
        TABLESPACE_NAME, 
        SUM(BYTES) / (1024 * 1024) AS FREE_SIZE_MB
     FROM 
        DBA_FREE_SPACE
     GROUP BY 
        TABLESPACE_NAME) fs
ON 
    df.TABLESPACE_NAME = fs.TABLESPACE_NAME;
```

## 批量删除日志
```sql
DECLARE
  v_batch_size NUMBER := 1000; -- 每批删除的记录数
  v_rows_deleted NUMBER;
BEGIN
  LOOP
    DELETE FROM sys_log
    WHERE content = '某值'
    AND ROWNUM <= v_batch_size;

    v_rows_deleted := SQL%ROWCOUNT; -- 获取删除的记录数

    COMMIT; -- 提交更改

    EXIT WHEN v_rows_deleted = 0; -- 如果没有更多记录需要删除，则退出循环
  END LOOP;
END;
/
```