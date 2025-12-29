<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
<h1>Oops — Error</h1>
<p>Status: ${status}</p>
<p>Error: ${error}</p>
<p>Message: ${message}</p>
<p>Path: ${path}</p>
</body>
</html>