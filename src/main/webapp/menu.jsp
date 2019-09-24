<%--
  Created by IntelliJ IDEA.
  User: mateu
  Date: 24.09.2019
  Time: 00:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>menu</title>
</head>
<body>
<a href="index.jsp">Home |</a>
<a href="kalkulatorKredytowy.jsp">| Kalkulator kredytowy</a>
<a href="prostyKalk.jsp">| Uproszczony kalkulator |</a>
<%=
request.getParameter("someParam")
%>

</body>
</html>
