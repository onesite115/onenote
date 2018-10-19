#Author: mehar.koduri@realpage.com
#Comments: If you see '#' front of any line, then it is a comment.
#Info: This is called feature. It is being called from e2e_orderflow.feature. You don't have to uncomment tags.
#Validations:: All the validations are done in here. Please look for keywords - 'Then' and 'match'
#Keywords: 'Then' is ment to validate that outcome status such as 200 or '201', 'Match' is for validating all the expected outcomes. 



Feature: 

				**************************************************************
        		
				Host: Look in karate-config.js file
				
				Endpoint: /v1/orders
				
        Method: 1) POST
        
        Questions: 
        1. The price for total kilometers or distance is rounded to nearest decimal fraction. But there is still some confusion on how lalamove calculates.
        2. For the point one, I decided not do further research and rounded to nearest fraction and calculated the price.
        
        ***************************************************************
				*************************************************************** 

Background:
* def sleep = read('classpath:com/onenote/utilities/sleep.js')
* def header_data = { Content-Type: '#(ContentType)', Accept: '#(Accept)' }
* url baseUrl


@ignore
@place_order
Scenario: 	API - POST /v1/orders

* def payloadToPlaceOrder = { payload: '#(payloadForPlacingOrderInJson)'}				
* def payload = payloadToPlaceOrder.payload
* headers header_data
* print "payload  ",payload

Given path 'v1/orders'
And request payload
When method post
Then status 201
* def numberOfStops = payload.stops.length
* print numberOfStops
* def numberOfStops = numberOfStops-1
* match response contains { id: '#number'}
* def numberOfdrivingDistances = response.drivingDistancesInMeters.length
* def drivingDistancesInMeters = response.drivingDistancesInMeters
* def sumOfKMS = []
* def sumOfKms = 0
* print "drivingDistancesInMeters ", drivingDistancesInMeters
* eval for(var i = 0; i < numberOfdrivingDistances; i++) { var mtrs = drivingDistancesInMeters[i]; var kms = mtrs/1000;   sumOfKms = kms + sumOfKms;  sumOfKMS.add(sumOfKms);     }

* print "sumOfKMS ", sumOfKMS[sumOfKMS.length - 1]
* match numberOfdrivingDistances == numberOfStops
* def dis1 = 0
* def dis2 = 0
* def distGrtTwo = []
* def totalDis = sumOfKMS[sumOfKMS.length - 1]
* print "totalDis ", totalDis
* eval if ( totalDis > 2 ) { dis1 = totalDis-2 ; distGrtTwo.add(dis1) ;}else{ dis2 = sumOfKMS[sumOfKMS.length - 1] ;  distGrtTwo.add(dis2);}  
* print "distBeyondTwoKMS : ", distGrtTwo[0]
* def costForFirstTwoKM = 2 * 20
* def totalCostForDistance = 0
* def totalPriceForTravel = []
* eval if ( distGrtTwo[0] > 2) { var roundOFkms = Math.round(distGrtTwo[0]*2)/2 ; var convertToMeters =  roundOFkms * 1000 ; var k = convertToMeters/200 ; var c = k * 5 ; totalCostForDistance = costForFirstTwoKM + c ; totalPriceForTravel.add(totalCostForDistance);  }else { totalCostForDistance = totalDis * 20 ; totalPriceForTravel.add(totalCostForDistance) ; }
* print "totalCostForDistance : ", totalCostForDistance
* print "totalCostForDistance : ", totalPriceForTravel[0]
* match response contains { id:'#number',drivingDistancesInMeters:'#[]', fare: {amount:'#string', currency: "HKD" }   }

