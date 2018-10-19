#Author: kmehar650@gmail.com

#Comments: If you see '#' front of any line, then it is a comment.
#Info: This is called feature. It is being called from e2e_orderflow.feature. You don't have to uncomment tags.
#Validations:: All the validations are done in here. Please look for keywords - 'Then' and 'match'
#Keywords: 'Then' is ment to validate that outcome status such as 200 or '201' etc, 'Match' is for validating all the expected outcomes. 



Feature: 

				**************************************************************
        		
				Host: Look in karate-config.js file
				
				Endpoint: /v1/orders/{orderID}
				
        Method: 1) GET
        
        Questions: 
        1. None
        
        
        INFO:
        1. OrderID comes from calling feature - e2e_orderflow.feature
        2. Response is validated in here using keywords such as 'Then' and 'Match'.
        3. orderDateTime - completed Date and Time is not asserted at this minute. but I have asserted partially using regular experssion.
        4. createdTime - completed Date and Time is not fully asserted at this minute. but I have asserted partially using regular experssion.
        
        ***************************************************************
				*************************************************************** 

Background:
* def sleep = read('classpath:com/onenote/utilities/sleep.js')
* def header_data = { Content-Type: '#(ContentType)', Accept: '#(Accept)' }
* url baseUrl


@ignore
@fetch_order
Scenario: 	API - GET /v1/orders/{orderID}


* def orderIDForFetch = { orderID: '#(orderId)'}				
* def orderID = orderIDForFetch.orderID
* print "orderID ::",orderID 
* headers header_data

Given path 'v1/orders'
And path orderID
When method GET
Then status 200

* match response.stops == '#[]'
* match response contains { id:'#number',stops:'#[]', drivingDistancesInMeters: '#[]'   }
* match response.status == "ASSIGNING"
* match response contains { status: 'ASSIGNING', orderDateTime: '#regex 2018.*Z' ,createdTime : '#regex 2018.*Z'}



