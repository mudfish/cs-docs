## 接口认证
```php
// auth.php
function verifyAuth() {
    $headers = getallheaders();
    if (isset($headers['Authorization'])) {
        $jwt = str_replace('Bearer ', '', $headers['Authorization']);
        $decoded = verifyJWT($jwt); // 使用之前定义的JWT验证函数
        if (!$decoded) {
            http_response_code(403);
            echo json_encode(['error' => 'Unauthorized']);
            exit;
        }
        return $decoded; // 返回解码后的JWT信息
    } else {
        http_response_code(400);
        echo json_encode(['error' => 'Token required']);
        exit;
    }
}
```

```php
// api1.php
require 'auth.php';
verifyAuth(); // 调用验证函数
// 接口具体逻辑
echo json_encode(['message' => 'Access granted for API 1']);
// api2.php
require 'auth.php';
verifyAuth(); // 调用验证函数
// 接口具体逻辑
echo json_encode(['message' => 'Access granted for API 2']);
```
