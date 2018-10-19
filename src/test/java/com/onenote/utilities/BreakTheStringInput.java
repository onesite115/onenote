package com.onenote.utilities;

import java.util.ArrayList;
import java.util.List;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonReader;
import javax.json.JsonValue;

import org.json.JSONArray;
import org.json.JSONObject;





public class BreakTheStringInput {
	
	
	public static  List<String>  coordinatesToSplit(String arg)
	{		
		String[] s1 = arg.split("#");
		String[] s2 = null;
		String[] s3 = null;
		
		List<String> listLatLng = new ArrayList<String>();			
		for(int i = 0 ; i < s1.length ; i++){
			s2 = s1[i].split("_");			
			for(int j =0 ; j < s2.length ; j++){
				listLatLng.add(s2[j]);
			}
		}	
		return listLatLng ;
	 
	}
}
