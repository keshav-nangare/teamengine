<%@ page
 language="java"
 session="false"
%><%!
String mode;
String test;
String sessionId;
%><!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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
<html>
	<head>
		<title>Executing Tests</title>
		<script>
			var TIMEOUT = 1000;
		    
			var timerId = 0;
			var form;
			var xhr;
			var sessionId;
			var threadId;
			var console;
			var busy = true;

			function start() {
				if (window.XMLHttpRequest) {
				  xhr = new XMLHttpRequest();
				} else {
				  xhr = new ActiveXObject("Microsoft.XMLHTTP");
				}

				var d = new Date();
<%
mode = request.getParameter("mode");
test = request.getParameter("test");
sessionId = request.getParameter("session");
String params = "mode=" + mode;
if (mode.equals("retest") || mode.equals("resume")) {
  if (test != null) {
    params += "&test=" + test;
  }
  if (sessionId != null) {
    params += "&session=" + sessionId;
  }
} else {
  params += "&sources=" + request.getParameter("sources");
  params += "&suite=" + request.getParameter("suite");
  params += "&description=" + request.getParameter("description");
}
%>
				var url = "test?te-operation=Test&<%=params%>&t=" + d.getTime();
				xhr.open("get", url, false);
				xhr.send(null);
				var xml = xhr.responseXML;
				var thread = xml.getElementsByTagName("thread")[0];
				threadId = thread.getAttribute("id");
				sessionId = thread.getAttribute("sessionId");

				console = window.open("console.html?t=" + d.getTime(), "te_console", "height=500,width=700,resizable=yes,scrollbars=yes");
				if (console) {
					console.focus();
				}
				timerId = setTimeout("update()", TIMEOUT);
			}
			
			function stop() {
				if (timerId != 0) {
					clearTimeout(timerId);
					timerId = 0;
				}
			    var d = new Date();
			    var url = "test?te-operation=Stop&thread=" + threadId + "&t=" + d.getTime();
				xhr.open("get", url, false);
				xhr.send(null);
				loadLog();
			}
			
			function update() {
				if (timerId != 0) {
					clearTimeout(timerId);
					timerId = 0;
				}
			    var d = new Date();
			    var url = "test?te-operation=GetStatus&thread=" + threadId + "&t=" + d.getTime();
				xhr.open("get", url, false);
				xhr.send(null);
				var xml = xhr.responseXML;
				var status = xml.getElementsByTagName("status")[0];
				var node = status.firstChild;
				var s = "";
				while(node) {
					if (node.nodeType == 4) {
						s += node.nodeValue;
					}
					node = node.nextSibling;
				}
				if (console && console.write && s != "") {
					console.write(s);
				}
				var form = status.getAttribute("form");
				if (form) {
					url = "test?te-operation=GetForm&thread=" + threadId + "&t=" + d.getTime();
					window.te_test_panel.location = url;
					window.te_test_panel.focus();
					busy = false;
				} else {
					var complete = status.getAttribute("complete");
					if (complete) {
//						alert("Testing Complete");
						loadLog();
					} else {
						if (!busy) {
							window.te_test_panel.location = "executing.html";
							busy = true;
						}
						timerId  = setTimeout("update()", TIMEOUT);
					}
				}
			}
			
			function loadLog() {
			    var d = new Date();
<%
if (mode.equals("retest") || mode.equals("resume")) {
  if (test == null) {
    out.println("\t\t\t\tvar url = \"viewSessionLog.jsp?session=" + sessionId + "\";");
  } else {
    out.println("\t\t\t\tvar url = \"viewTestLog.jsp?test=" + test + "\";");
  }
} else {
  out.println("\t\t\t\tvar url = \"viewSessionLog.jsp?session=\" + sessionId;");
}
%>
				window.location = url + "&t=" + d.getTime();
			}
		</script>
	</head>
	<frameset onload="start()" rows="102,*">
	    <frame name="te_test_controls" src="testControls.html">
    	<frame name="te_test_panel" src="executing.html">
	</frameset>
</html>