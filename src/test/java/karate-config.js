function() {    
	var env = karate.env; // get system property 'karate.env'
	 
	 var protocol = 'https'; 
	 
	 if (env != "qa"){
		    env = "qa";
	 }
	
	 var config = {   env: env	  };
	  
	  if (env == "dev") 
	  {
		  config.baseUrl = "https://host/";
	  } else if (env == "qa") 
	  {
	      config.baseUrl = "http://localhost:51544/";
	  } else if (env == "int") 
	  {
	      config.baseUrl = "https://host/";
	  } else if (env == "sat") 
	  {
	      config.baseUrl = "https://host/";
	  }
	  
	 
	  
	  // header data //
	  config.ContentType ="application/json;charset=UTF-8";
	  config.Accept ="application/json text/plain, */*" ;
	  
	  karate.log("Running on environment: ", env);
	  karate.configure("logPrettyRequest", true);
	  karate.configure("logPrettyResponse", true);
	  
	  karate.configure('connectTimeout', 15000);
	  karate.configure('readTimeout', 15000);
	 
  return config;
}