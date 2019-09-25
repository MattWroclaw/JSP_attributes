package kalkulator;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class Arkusz extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.ms-excel");
        PrintWriter out =response.getWriter();
        out.print("\tQ1\tQ2\tQ3\tQ4\tTOTAL");
        out.print("Jabłka\t23\t10\t7\t15\tTOTAL");
        out.print("Gruszki\t11\t9\t5\t3\tTOTAL");
    }

}
