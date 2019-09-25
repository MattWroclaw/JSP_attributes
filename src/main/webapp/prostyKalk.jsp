<%@ page import="kalkulator.KalkulatorKredytowy" %>
<%@ page import="java.time.LocalDateTime" %><%--
  Created by IntelliJ IDEA.
  User: mateu
  Date: 24.09.2019
  Time: 21:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Uproszczony kalkulator</title>
</head>
<body>
<jsp:include page="menu.jsp">
    <jsp:param name="someParam"
               value="3"/>
</jsp:include>

<h2>Kalkulator kredytowy</h2>

Kalkulator działa w oparciu o wzór: <br>
q = 1+(b/m)<br>
R = A * (q^n) * (q-1)/[(q^n) - 1]<br>
C = R * n<br>
```
```<br>
m - liczba miesięcy w okresie rozliczeniowym<br>
A - wysokość kredytu<br>
b - oprocentowanie w skali roku<br>
n - ilość rat do spłaty (m=?n)<br>
R - wysokość raty<br>
C - całkowita kwota do spłaty<br>

<h3>Dane wejściowe</h3>

<form action="prostyKalk.jsp" method="post">
    <label for="wysokoscKredytuID">Wysokość kredytu: </label>
    <input type="number" id="wysokoscKredytuID" name="wysokoscKredytu" value="10">

    <label for="rocznaStopaProcId">Roczna stopa procentowa: </label>
    <input type="text" id="rocznaStopaProcId" name="rocznaStopa" value="10">

    <label for="ileMiesiecyId">Na ile miesięcy: </label>
    <input type="number" id="ileMiesiecyId" name="ileMiesiecy" value="10">

    <input type="submit" value="Zatwierdź">
</form>

<%
    String A = request.getParameter("wysokoscKredytu");
    String b = request.getParameter("rocznaStopa");
    String m = request.getParameter("ileMiesiecy");
//    out.print(A);
//    out.print(b);
//    out.print(m);

    double q =0;
    double R =0;
    double C =0;

    try {
    double dA = Double.parseDouble(A);
    double db = Double.parseDouble(b);
    double dm = Double.parseDouble(m);
    KalkulatorKredytowy kk= new KalkulatorKredytowy();
    if(A != null && b != null && m != null){
         q = kk.q(db, dm);
         R = kk.R(dA, q, dm);
         C = kk.C(R, dm);
    }
    }catch (Exception e){
        out.print("Uuu.... Coś poszło nie tak..<br> ");
    }
    out.print("Kwota kredytu(PLN): " + A + "<br>");
    out.print("Roczna stopa procentowa " + b + "<br>");
    out.print("Okres płaty kredytu (w miesiącach) " + m + "<br>");
    out.print("Pomocnicza wartość q= " + Math.round(q) + "<br>");
    out.print("Wyskokość raty (wartość R)= " + Math.round(R) + "<br>");
    out.print("Całkowita kwota do spłaty (wartość R)= " + Math.round(C) + "<br>");

    LocalDateTime dzis = LocalDateTime.now();
    double doSplacenia = 0;

    try {
    int licznaMiesiecy = Integer.valueOf(m);
    out.print("<table>");
    out.print("<th>Nmer raty |</th><th>Wysokość raty |</th><th>Termin spłaty |</th><th>Wysokość pozostałego kapitału do spłacenia |</th>");
    for (int i = 1; i <= licznaMiesiecy; i++) {
        doSplacenia = Math.round((C - i * R)*100.0)/100.0;
        out.print("<tr>");
        out.print("<td> |" + i + "|</td>" + "<td>|" + Math.round(R*100.0)/100.0 + "|</td>" + "<td>|" + dzis.plusMonths(i).toLocalDate() + "|</td>" + "<td>|" + doSplacenia + "</td>");
        out.print("</tr>");
    }
    }catch (Exception e){
        out.print("<h3>Żeby uzyskać harmonogram spłaty" +
                "wypełnij formularz i naciśnij <em>'Zatwierdź'</em></h3>");
    }
%>

</body>
</html>
