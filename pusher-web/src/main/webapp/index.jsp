<%@ page import="javax.naming.InitialContext" %>
<%@ page import="org.springframework.jms.core.JmsTemplate" %>
<%@ page import="org.springframework.jms.core.MessageCreator" %>
<%@ page import="javax.jms.*" %>
<%@ page import="java.util.Date" %>
<% boolean useJndi = "true".equals(request.getParameter("use-jndi")); %>
<html>
<body>
<h2>Sent a message</h2>
<form action="index.jsp" method="GET">
  <p><input type="checkbox" id="use-jndi" name="use-jndi" value="true" <%=useJndi ? "checked=\"checked\"" : ""%>/>
    <label for="use-jndi">Use jndi destionation lookup</label></p>
  <input type="submit" value="topic" name="send"/>
  <input type="submit" value="queue" name="send"/>
</form>

<%
  InitialContext ic = new InitialContext();
  ConnectionFactory cf = (ConnectionFactory) ic.lookup("jms/TestConnectionFactory");
  JmsTemplate jt = new JmsTemplate(cf);
  try{
    MessageCreator mc = new MessageCreator() {
      @Override
      public Message createMessage(Session session) throws JMSException {
        ObjectMessage om = session.createObjectMessage();
        om.setObject("This is a message :" + new Date());
        return om;
      }
    };
    if( "queue".equals(request.getParameter("send"))){
      if(useJndi){
        Destination d = (Destination) ic.lookup("jms/MyQueue");
        jt.send(d, mc);
      }else{
        jt.send("MyQueue", mc);
      }
      out.println("<br/>Queue message sent, use-jndi:" + useJndi);
    }
    if( "topic".equals(request.getParameter("send"))){
      jt.setPubSubDomain(true);
      if(useJndi){
        Destination d = (Destination) ic.lookup("jms/MyTopic");
        jt.send(d, mc);
      }else{
        jt.send("MyTopic", mc);
      }
      out.println("<br/>Topic message sent , use-jndi:" + useJndi);
    }
  }catch(Exception e){
    throw new RuntimeException(e);
  }
%>
</body>
</html>
