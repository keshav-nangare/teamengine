<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="java.io.File"%>
<%@page import="com.occamlab.te.web.AdminLogCreator"%>
<%@ page
  language="java"
  session="false"
  %>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    </head>
    <body>
      <%@ include file="header.jsp" %>
      <% String teBasePath = getServletContext().getInitParameter("teConfigFile");
        File LogDir = null;
        if (LogDir == null) {
          if (null != System.getProperty("USERS")) {
            LogDir = new File(System.getProperty("USERS"));
          } else if (null != System.getenv("USERS")) {
            LogDir = new File(System.getenv("USERS"));
          } else {
            LogDir = new File(teBasePath.split("config.xml")[0] + "users");
          }
        }
        
        try {
          File fXmlFile = new File(teBasePath);
          DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
          DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
          Document doc = dBuilder.parse(fXmlFile);
          doc.getDocumentElement().normalize();
          NodeList nList = doc.getElementsByTagName("standard");
          out.println("<h1>Statistics</h1>");
          out.println("<b>Users log directory:</b> " + LogDir.toString()+"<br/>");
          out.println("<h3>by Executions (Sessions)</h3>");
          out.println("Count number of times users have executed a run towards a particular test.<br/><br/>");
          out.println("<table border='1'>");
          out.println("<tr style='height:22px;'>");
          out.println("<td>" + "<b>Test suite name</b>" + "</td>");
          out.println("<td>" + "<b>Version</b>" + "</td>");
          out.println("<td>" + "<b>Last Month</b>" + "</td>");
          out.println("<td>" + "<b>Last 3 Months</b>" + "</td>");
          out.println("<td>" + "<b>Last Year</b>" + "</td>");
          out.println("<td>" + "<b>All Times</b>" + "</td>");
          out.println("</tr>");
          for (int temp = 0; temp < nList.getLength(); temp++) {
            String testName = "";
            Element nNode = (Element) nList.item(temp);
            NodeList nName = nNode.getElementsByTagName("name");
            for (int nameCount = 0; nameCount < 2; nameCount++) {
              if (testName != "") {
                testName = testName + "_";
              }
              testName = testName + nName.item(nameCount).getTextContent();
            }
            AdminLogCreator adminLogCreator = new AdminLogCreator();
            adminLogCreator.processForExecutions(testName, LogDir);
            out.println("<tr style='height:23px;'>");
            out.println("<td>" + nName.item(0).getTextContent() + "</td>");
            out.println("<td>" + nName.item(1).getTextContent() + "</td>");
            out.println("<td>" + adminLogCreator.getCountLastMonth() + "</td>");
            out.println("<td>" + adminLogCreator.getCountLast3Month() + "</td>");
            out.println("<td>" + adminLogCreator.getCountLastYear() + "</td>");
            out.println("<td>" + adminLogCreator.getCountAllTime() + "</td>");
            out.println("</tr>");
          }
          out.println("</table>");
          out.println("<br/><br/>");
          out.println("<h3>by USERS</h3>");
          out.println("How many different users have run in the last month a particular test.<br/><br/>");
          out.println("<table border='1'>");
          out.println("<tr style='height:22px;'>");
          out.println("<td>" + "<b>Test suite name</b>" + "</td>");
          out.println("<td>" + "<b>Version</b>" + "</td>");
          out.println("<td>" + "<b>Last Month</b>" + "</td>");
          out.println("<td>" + "<b>Last 3 Months</b>" + "</td>");
          out.println("<td>" + "<b>Last Year</b>" + "</td>");
          out.println("<td>" + "<b>All Times</b>" + "</td>");
          out.println("</tr>");
          for (int temp = 0; temp < nList.getLength(); temp++) {
            String testName = "";
            Element nNode = (Element) nList.item(temp);
            NodeList nName = nNode.getElementsByTagName("name");
            for (int nameCount = 0; nameCount < 2; nameCount++) {
              if (testName != "") {
                testName = testName + "_";
              }
              testName = testName + nName.item(nameCount).getTextContent();
            }
            AdminLogCreator adminLogCreator = new AdminLogCreator();
            adminLogCreator.processForUsers(testName, LogDir);
            out.println("<tr style='height:23px;'>");
            out.println("<td>" + nName.item(0).getTextContent() + "</td>");
            out.println("<td>" + nName.item(1).getTextContent() + "</td>");
            out.println("<td>" + adminLogCreator.getCountLastMonth() + "</td>");
            out.println("<td>" + adminLogCreator.getCountLast3Month() + "</td>");
            out.println("<td>" + adminLogCreator.getCountLastYear() + "</td>");
            out.println("<td>" + adminLogCreator.getCountAllTime() + "</td>");
            out.println("</tr>");
          }
          out.println("</table>");
        } catch (Exception e) {
          e.printStackTrace();
        }
      %>
      <br/>
      <section id="noColumn">
        <a href="viewSessions.jsp" style="text-decoration: none">
          <span class="box">Sign in</span></a>
        or
        <a href="register.jsp" style="text-decoration: none">
          <span class="box">Create an account</span></a>
      </section>
      <%@ include file="footer.jsp" %>
    </body>
  </html>