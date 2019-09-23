<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: mateu
  Date: 22.09.2019
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JSP Atributes</title>
</head>
<body>
<jsp:include page="menu.jsp">
    <jsp:param name="someParam"
               value="1"/>
</jsp:include>

<h2>tabela zawierającą wszystkie nagłówki HTTP wraz z ich wartościami</h2>

<%
    Enumeration<String> headerNames = request.getHeaderNames();
    out.print("<table>");
    while (headerNames.hasMoreElements()) {
        String header = headerNames.nextElement();
        out.print("<tr>");
        out.print("<td>" + header + "</td>" + "<td>" + request.getHeader(header) + "</td>");
        out.print("</tr>");
    }
    out.print("</table><br><br>");
%>
<h2> Tabela zawierająca odebrane ciasteczka name:value</h2>
<%

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        out.print("<table>");
        for (Cookie c : cookies) {
            out.print("<tr>");
            out.print("<td>" + c.getName() + "</td>" + "<td>" + c.getValue() + "</td>");
            out.print("</tr>");
        }
        out.print("</table><br><br>");
    } else {
        out.print("Nie znaleziono ciasteczek");
    }
%>

<%
//    String klucz = request.getParameter("klucz");
//    String wartosc = request.getParameter("wartosc");
//    String czas = request.getParameter("czas");
//    int czasInt = Integer.parseInt(czas);
//    Cookie c = new Cookie(klucz, wartosc);
//    c.setMaxAge(czasInt);
//    response.addCookie(c);
%>

<form action="index.jsp" method="post">
    <label for="klucz">klucz</label>
    <input type="text" id="klucz" name="klucz"/>

    <label for="wartosc">wartosc</label>
    <input type="text" id="wartosc" name="wartosc"/>

    <label for="czas">czas</label>
    <input type="text" id="czas" name="czas"/>

    <input type="submit" value="Wyślij"/>
</form>
<h2>Zawartość sesji użytkownika</h2>
<%
    session.setAttribute("preferredCurrency", "PLN");

    out.println(session.getAttribute("preferredCurrency"+"<br>"));
    out.println(session.getMaxInactiveInterval()+"<br>");
//    out.println(Date(session.getCreationTime())+"<br>");
    out.println(session.getId()+"<br>");
    out.println(session.getServletContext()+"<br>");
    Enumeration<String> attributeNames = session.getAttributeNames();
    while (attributeNames.hasMoreElements()){
        out.print("Nazwa atrybutu "+attributeNames.nextElement()+"<br>");
    }
%>

</body>
</html>
