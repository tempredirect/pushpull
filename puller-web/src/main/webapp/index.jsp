<%@ page import="java.util.List" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  ApplicationContext applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(application);
  List<String> topicMessages = applicationContext.getBean("topicMessages", List.class); 
  List<String> queueMessages = applicationContext.getBean("queueMessages", List.class); 
%>
<html>
<head>
  <title>T : <%=topicMessages.size()%> / Q : <%=queueMessages.size()%></title>
  <meta http-equiv="refresh" content="1">
</head>

<body>
<table>
  <thead>
  <tr>
    <th>Topic Messages</th>
  </tr>
  </thead>
  <tbody>
  <% for(String message : topicMessages){ %>
  <tr>
    <td><%=message%></td>
  </tr>
  <% } %>
  </tbody>
</table>
<table>
  <thead>
  <tr>
    <th>Queue Messages</th>
  </tr>
  </thead>
  <tbody>
  <% for(String message : queueMessages){ %>
  <tr>
    <td><%=message%></td>
  </tr>
  <% } %>
  </tbody>
</table>
</body>
</html>