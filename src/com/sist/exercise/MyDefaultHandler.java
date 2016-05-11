package com.sist.exercise;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
/*
 *   SAX ==> Simple API for XML
 *   <?xml version="1.0"> startDocument
 *   <root> : 테이블명 startElement
 *    <name></name>
 *    startElement characters endElement
 *    <sex></sex>
 *    startElement characters endElement
 *    <age></age>
 *    startElement characters endElement
 *   </root>
 *    endDocument
 */
import java.util.*;

public class MyDefaultHandler extends DefaultHandler{
    Map map = new HashMap();
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		try{
			if(qName.equals("Resource"))
			{
				String driver=attributes.getValue("driverClassName");
				String url=attributes.getValue("url");
				String username=attributes.getValue("username");
				String password=attributes.getValue("password");
				String maxIdle=attributes.getValue("maxIdle");
				String maxActive=attributes.getValue("maxActive");
				String maxWait=attributes.getValue("maxWait");
				String type=attributes.getValue("type");
				String name=attributes.getValue("name");
				
				Class clsName=Class.forName(type); // 메모리 할당
				MyDataSource ms =(MyDataSource)clsName.newInstance();
				ms.setDriverClassName(driver);
				ms.setMaxActive(Integer.parseInt(maxActive));
				ms.setPassword(password);
				ms.setUrl(url);
				ms.setUsername(username);
				ms.setMaxWait(Integer.parseInt(maxWait));
				ms.setMaxIdle(Integer.parseInt(maxIdle));
				ms.driverLoading();
				map.put(name, ms);
			}
		}catch(Exception ex){
			ex.getMessage();
		}
	}

}
