#Author: kmehar650@gmail.com

#Comments: If you see '#' front of any line, then it is a comment.
#Info: This is called feature. It is being called from e2e_orderflow.feature. You don't have to uncomment tags.
#Validations:: All the validations are done in here. Please look for keywords - 'Then' and 'match'
#Keywords: 'Then' is ment to validate that outcome status such as 200 or '201' etc, 'Match' is for validating all the expected outcomes. 



Feature: 

				**************************************************************
        		
				Host: Look in karate-config.js file
				
				Endpoint: /v1/orders/{orderID}/cancel
				
        Method: 1) PUT
        
        Questions: 
        1. None
        
        
        INFO:
        1. OrderID comes from calling feature - e2e_orderflow.feature
        2. Response is validated in here using keywords such as 'Then' and 'Match'.
        3. cancelledAt - cancelled Date and Time is not fully asserted at this minute. but I have asserted partially using regular experssion.
        
        ***************************************************************
				*************************************************************** 

Background:
* def sleep = read('classpath:com/onenote/utilities/sleep.js')
* def header_data = { Content-Type: '#(ContentType)', Accept: '#(Accept)' }
* url baseUrl


@ignore
@ongoing_order
Scenario: 	API - PUT /v1/orders/{orderID}/cancel


* def orderIDForFetch = { orderID: '#(orderId)'}				
* def orderID = orderIDForFetch.orderID
* print "orderID ::",orderID 
* headers header_data

Given path 'v1/orders'
And path orderID
And path '/cancel'
And request ''
When method PUT
Then status 200
* match response contains { id:'#number',status: 'CANCELLED', cancelledAt: '#regex 2018.*Z' }
* match response.status == "CANCELLED"

### the below is to verify completed date and time, in other words to assert expected vs actual. It is still being worked. 

* def orderCancelledDateTime = response.cancelledAt
* print "orderCancelledDateTime : ", orderCancelledDateTime

* def dateArr1 = []

* def currentDateFunction = 
					"""
						function() {
						var today = new Date();
    				var dd = today.getDate();
    		    var mm = today.getMonth()+1; //January is 0!
    		    var yyyy = today.getFullYear();
    		    var hours = today.getHours();
    		    if(hours < 1) { hours = '0'+hours ; }
    		    var minutes = today.getMinutes();    		    
    		    if(minutes < 10) { minutes = '0'+minutes ; }
    		    var seconds = today.getSeconds();
    		    if(seconds < 10) { seconds = '0'+seconds ; }    
    		    var currentDate = yyyy+"-"+mm+"-"+dd+ " "+hours+":"+minutes+":"+seconds ;
    		    dateArr1.add(yyyy);
    		    dateArr1.add(mm);
    		    dateArr1.add(dd);
    		     dateArr1.add(dd);
    	      return currentDate ;	
    	      }			
					"""

* def currentDate = call currentDateFunction


