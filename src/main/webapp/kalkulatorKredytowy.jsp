<%@ page import="kalkulator.KalkulatorKredytowy" %>
<%@ page import="java.time.LocalDateTime" %>
<%--
  Created by IntelliJ IDEA.
  User: mateu
  Date: 23.09.2019
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kalkulator kredytowy</title>
</head>
<body>
<jsp:include page="menu.jsp">
    <jsp:param name="someParam"
               value="2"/>
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
<form action="kalkulatorKredytowy.jsp" method="post">
    <label for="wysokoscKredytuID">Kwota kredytu(PLN): </label>
    <input type="text" id="wysokoscKredytuID" name="kwotaKredytu"
    <%--           value="<% findPropperValueFmCookie(request.getCookies(), "kwotaKredytu"); %>"><br>--%>
           value="10">
    <label for="rspId">Roczna stopa procentowa (np. 2% = 0.02)</label>
    <input type="text" id="rspId" name="stopaProc"
    <%--           value="<% findPropperValueFmCookie(request.getCookies(), "stopaProc");%>"><br>--%>
           value=".05">
    <label for="ileMiesId">Okres płaty kredytu (w miesiącach)</label>
    <input type="text" id="ileMiesId" name="miesiace"
    <%--           value="<%  findPropperValueFmCookie(request.getCookies(),"miesiace" ); %>"><br>--%>
           value="12">
    <input type="submit" value="Zatwierdź">
</form>

<%!
    private String findPropperValueFmCookie(Cookie[] cookies, String name) {
        for (Cookie cook : cookies) {
            if (cook.getName().equals(name)) {
                return cook.getValue();
            }
        }
        return "1";
    }
%>

<%
    String A = request.getParameter("kwotaKredytu");
    String b = request.getParameter("stopaProc");
    String m = request.getParameter("miesiace");

    boolean czySaDaneZFormularza = A != null && b != null && m != null;
    boolean czyDaneSaPoprawne = (A.matches("^[1-9]+[0-9]{0,}([.][0-9]){0,1}[0-9]+$"))
            && (b.matches("^[0]*[.][\\d]+$"))
            && (m.matches("^[1-9][\\d]*$"));

    if (czySaDaneZFormularza) {
        Cookie cKredyt = new Cookie("kwotaKredytu", A);
        response.addCookie(cKredyt);

        Cookie stopa = new Cookie("stopaProc", b);
        response.addCookie(stopa);

        Cookie ileMies = new Cookie("miesiace", m);
        response.addCookie(ileMies);
    }

    double q = 0;
    double R = 0;
    double C = 0;
    if (czySaDaneZFormularza) {
        if (czyDaneSaPoprawne) {

            double d_A = Double.valueOf(A);
            double d_b = Double.parseDouble(b);
            double d_m = Double.parseDouble(m);
            KalkulatorKredytowy kk = new KalkulatorKredytowy();
            q = kk.q(d_b, d_m);
            R = kk.R(d_A, q, d_m);
            C = kk.C(R, d_m);
        } else {
            out.print("<h3>Dane w formularzu mogą być tylko liczbami (dodatnimi)</h3>");
        }
    } else {
        out.print("<h3>Wypełnij formularz i naciśnij <em>'Zatwierdź'</em> </h3>");
    }
%>
<h3>Dane wyjściowe:</h3>
<%
    out.print("Kwota kredytu(PLN): " + A + "<br>");
    out.print("Roczna stopa procentowa " + b + "<br>");
    out.print("Okres płaty kredytu (w miesiącach) " + m + "<br>");
    out.print("Pomocnicza wartość q= " + q + "<br>");
    out.print("Wyskokość raty (wartość R)= " + R + "<br>");
    out.print("Całkowita kwota do spłaty (wartość R)= " + C + "<br>");
%>
<h3>Harmonogram płatności</h3>
<%

    LocalDateTime dzis = LocalDateTime.now();
    out.print(dzis.toLocalDate());
    if (czyDaneSaPoprawne) {
        double doSplacenia = 0;
        int licznaMiesiecy = Integer.valueOf(m);
        out.print("<table>");
        out.print("<th>Nr raty |</th><th>Wysokość raty |</th><th>Termin spłaty |</th><th>Wysokość pozostałego kapitału do spłacenia |</th>");
        for (int i = 1; i <= licznaMiesiecy; i++) {
            doSplacenia = Math.round((C - i * R) * 100.0) / 100.0;
            out.print("<tr>");
            out.print("<td> |" + i + "|</td>" + "<td>|" + Math.round(R * 1000.0) / 1000.0 + "|</td>" + "<td>|" + dzis.plusMonths(i).toLocalDate() + "|</td>" + "<td>|" + doSplacenia + "</td>");
            out.print("</tr>");
        }
    } else {
        out.print("<h3>Żeby uzyskać harmonogram spłaty" +
                "wypełnij formularz i naciśnij <em>'Zatwierdź'</em></h3> ");
    }
%>
</body>
</html>
