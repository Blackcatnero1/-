package com.human.boo.util;


import java.util.*;

public class ChatbotUtil {
	
	public Map<String, Object> createSimpleTextTemplate(String text) {
	    Map<String, Object> template = new HashMap<>();
	    Map<String, Object> output = new HashMap<>();
	    output.put("simpleText", text);
	    List<Map<String, Object>> outputsList = new ArrayList<>();
	    outputsList.add(output);
	    template.put("outputs", outputsList);
	    return template;
	}
	

}
