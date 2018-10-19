package com.onenote.parsers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Scanner;

import javax.json.JsonObject;
import javax.json.JsonWriter;

import org.json.JSONWriter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.onenote.utilities.CommonUtils;



public class Coordinates {	
	
	
	    @SuppressWarnings("unchecked")
	    public static JSONObject latitudeAndLongitudeAppend(String jsonFile, List<String>  latitudeAndLongitude)
	            throws FileNotFoundException, IOException, ParseException {
	    	
	    	Map<String, Double> item_sub1 = new LinkedHashMap<String, Double> ();
	    	JSONParser parser = new JSONParser();
            Object object = parser.parse(new FileReader(jsonFile));	            
            JSONObject jsonObject = (JSONObject)object;
            jsonObject = emptystopsArray(jsonObject);
            JSONArray stopsArray = (JSONArray)jsonObject.get("stops");
            JSONObject stopsJsonObject = new JSONObject();
	    	Iterator<String> listItr = latitudeAndLongitude.iterator();
	    	
	    	while(listItr.hasNext())
	    	 {  
	    	    String s1 = listItr.next();
	    	    if(s1.contains("lat"))
	    	    {
	    	      String[] s2 = s1.split("lat:"); 
	    	      item_sub1.put("lat", Double.parseDouble(s2[1]))  ;	     
	    	      stopsJsonObject.put("lat", Double.parseDouble(s2[1]));	    	      
	    	    }else if(s1.contains("lng"))
	    	    {
	    	      String[] s2 = s1.split("lng:");
	    	      item_sub1.put("lng", Double.parseDouble(s2[1]))  ;
	    	      stopsJsonObject.put("lng", Double.parseDouble(s2[1]));
	    	      
	    	      JSONObject json = new JSONObject(item_sub1);
	    	      
	    	      stopsArray.add(item_sub1);
	    	      item_sub1 = null;
	    	      stopsJsonObject = null;
	    	      stopsJsonObject = new JSONObject();
	    	      item_sub1 = new LinkedHashMap<String, Double> ();
	    	    }
	    	 }
	    	   
	         FileWriter fileWriter = new FileWriter(jsonFile);
	         fileWriter.write(jsonObject.toJSONString());
	        // jsonObject = createNewPlaceOrderPayload(jsonObject);
	         fileWriter.flush();
	         fileWriter.close();
	         return jsonObject;
	    }
	    
	    public static JSONObject createNewPlaceOrderPayload(JSONObject jsonObject ) throws IOException
	    {
	    	String folderForPlaceJSON = CommonUtils.getPropValues("NEWPLACEORDER_JSON_FILE_LOCATION");
            System.out.println("folderForPlaceJSON "+ folderForPlaceJSON);
            File file1 = new File(folderForPlaceJSON + System.getProperty("file.separator") + "newPlaceOrder.json");
            if(!file1.exists())
            {
            	file1.createNewFile();
            }        
            FileWriter fileWriter = new FileWriter(file1.getAbsolutePath());
            fileWriter.write(jsonObject.toJSONString());
            System.out.println("jsonObject. "+ jsonObject);
            fileWriter.flush();
            fileWriter.close();
            return jsonObject;
          
	    }
	    
	    public static JSONObject emptystopsArray(JSONObject jsonObject )
	    {
	    	 	
	            JSONArray stopsArray = (JSONArray)jsonObject.get("stops");
	            stopsArray.clear();
	            JSONObject stopsJsonObject = new JSONObject();
	            System.out.println("jsonObject EMPTY:  "+ jsonObject);
	            return jsonObject;
	    }
	    
	    public static void main(String[] args) throws FileNotFoundException, IOException, ParseException {
			
	    	/*String arg= "lat:26.344674_lng:119.124651#lat:28.344555_lng:112.154854";
	    	
	    	//stringSplit3( arg);
	    	//latitudeAndLongitudeAppend("");
	    	String jsonFile = CommonUtils.getPropValues("PLACEORDER_FILE");
	    	System.out.println("file : "+ jsonFile);
	    	List<String> lis = BreakTheStringInput.coordinatesToSplit(arg);
	    	//System.out.println(lis);
	    	latitudeAndLongitudeAppend(jsonFile , lis ) ;*/
	    	/*String arg= "lat:26.344674_lng:119.124651#lat:28.344555_lng:112.154854";
	    	String jsonFile = CommonUtils.getPropValues("PLACEORDER_FILE");
	    	System.out.println("file : "+ jsonFile);
	    	List<String> lis = BreakTheStringInput.coordinatesToSplit(arg);
	    	//System.out.println(lis);
	    	latitudeAndLongitudeAppend(jsonFile , lis ) ;*/
				
		}

}
