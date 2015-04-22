<%@ page
  language="java"
  session="false"
  import="java.io.File, javax.xml.parsers.*, java.util.Arrays, com.occamlab.te.web.*"
%><%!
  Config Conf;
  DocumentBuilder DB;

  public void jspInit() {
    Conf = new Config();
    try {
      DB = DocumentBuilderFactory.newInstance().newDocumentBuilder();
    } catch (Exception e) {
      e.printStackTrace(System.out);
    }
  }
  %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  
    The contents of this file are subject to the Mozilla Public License
    Version 1.1 (the "License"); you may not use this file except in
    compliance with the License. You may obtain a copy of the License at
    http://www.mozilla.org/MPL/ 
  
    Software distributed under the License is distributed on an "AS IS" basis,
    WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
    the specific language governing rights and limitations under the License. 
  
    The Original Code is TEAM Engine.
  
    The Initial Developer of the Original Code is Northrop Grumman Corporation
    jointly with The National Technology Alliance.  Portions created by
    Northrop Grumman Corporation are Copyright (C) 2005-2006, Northrop
    Grumman Corporation. All Rights Reserved.
  
    Contributor(s): No additional contributors to date
  
   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <title>Test Sessions</title>
      <script>
        function deleteSession() {
          var sessionid=document.getElementById("SessionID").value;
          if(sessionid!=""){
				if (confirm("Are you sure you want to delete session "+sessionid+" ?")) {
					window.location = "deleteSession?session="+sessionid
				}
          }else{
            alert("Please select session ID.");
          }}
          </script>
    </head>
    <body>
      <%@ include file="header.jsp" %>
      <h2>Test Sessions</h2>
      <p>
        <select  id="SessionID" name="Organization">
          <option value="">SessionID</option>
        
        <%  File userdir = new File(Conf.getUsersDir(), request.getRemoteUser());
          String[] dirs = userdir.list();
          Arrays.sort(dirs);

          for (int i = 0; i < dirs.length; i++) {
            if (new File(new File(userdir, dirs[i]), "session.xml").exists()) {
              TestSession s = new TestSession();
              s.load(userdir, dirs[i]);
              out.println("<option value='"+s.getSessionId()+"'>"+s.getSessionId()+"</option>");
            }
          }
        %>
        </select>
        <input type="button" value="Delete this session" onclick="deleteSession()"/>
        <br/>
      </p>
        <p><a href="viewSessions.jsp">Sessions list</a></p>
      <%@ include file="footer.jsp" %>
    </body>
  </html>
