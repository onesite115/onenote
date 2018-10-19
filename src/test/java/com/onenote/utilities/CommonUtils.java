package com.onenote.utilities;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class CommonUtils {
	
	public static String getPropValues(String propertieskey) throws IOException {
		String value = null;

		try {     	
			File file = new File(System.getProperty("user.dir")+System.getProperty("file.separator") + "src"  + System.getProperty("file.separator")
					+ "test" + System.getProperty("file.separator" ) +"java"+ System.getProperty("file.separator") +"test.properties");			
			FileInputStream fileInput = new FileInputStream(file);			
			Properties properties = new Properties();
			properties.load(fileInput);			
			value = System.getProperty("user.dir")+properties.get(propertieskey) ;			
			fileInput.close();			
    	}catch(Exception e)
		{	System.out.println(e);
		}
		return value;
	}
	
	
	
	public static void main(String[] args) throws IOException {
		System.out.println(CommonUtils.getPropValues("PLACEORDER_FILE"));
		
	}

}
