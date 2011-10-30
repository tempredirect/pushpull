package com.lps.puller;

import org.springframework.jms.JmsException;
import org.springframework.jms.support.converter.MessageConversionException;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;
import java.util.List;

/**
 * @author gareth
 */
public class PullerMessageListener implements MessageListener {
    
    List<String> messages ;
    
    @Override
    public void onMessage(Message message) {
        ObjectMessage objectMessage = (ObjectMessage) message;

        try {
            messages.add(String.valueOf(objectMessage.getObject()));
        } catch (JMSException e) {
            throw new MessageConversionException("Wibble",e);
        }
    }

    public void setMessages(List<String> messages) {
        this.messages = messages;
    }
}
