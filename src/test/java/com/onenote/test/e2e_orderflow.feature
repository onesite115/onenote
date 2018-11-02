###############################################################

#Author: kmehar650@gmail.com
                                    #### NOTE - These 7 lines are important to read. ####
                                    
#Comments: If you see '#' front of any line, then it is a comment.
#ignore: If you want to run this feature with the scenario then put '#' before '@ignore' tag. You will find it above 'Scenraio Outline'.
#Scenarios: Two scenarios executed - one with order complete and another one with order cancel.
#Validations: The status code 404 and 422 scenarios (order not exist) are not scripted because of time.


#INFO: If you see '#INFO' then the following line will be a call to a feature file that internally calls respective api.
#Note: You don't have to put or uncomment tag in called feature file. This is main end-2-end file and it is enough for anyone to run all apis to test.
#Note: This is calling feature, it calls other feature files (called feature) that has individual apis.
#Examples - For input test data, you can maintain same format to send N number of inputs. Each line is one test data set or one test case data.
#Validations: All the validations are done in respective api call feature files. ex: see line 146 and navigate to or open feature file.

###############################################################


###############################################################
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template
###############################################################


Feature: 
        
        This feature lets you test - create order, fetch order, and wait for driver to take order, and then driver will comlete order or cancel order.
        To complete this scenario, this feature (calling feature) calls respective api feature (called feature) files.
        
        
   			**************************************************************
   			
				A: My views or queries for /v1/orders - POST :
				 
        1. The price for total kilometers or distance is rounded to nearest decimal fraction. but there is still some confusion on how lalamove calculates.
        2. For the point one, I decided not to do further research and rounded to nearest fraction and calculated the price.
        3. Please see api_post_placeOrder.feature for the above two points.
        4. For inputs - latitudes and longitudes see 'Examples' at the bottom. 
        5. Examples - For input test data, you can maintain same format to send N number of inputs. Each line is one test data set or one test case data.
        
        -------------------------------------------------------
        
        B: My views or queries for /v1/orders/{orderID} - GET :
        
        1. Please see feature file - api_get_OrderDetails.feature.
        
        -------------------------------------------------------
        
        C: My views or queries for /v1/orders/{orderID}/take - PUT :
        
        1. Please see feature file - api_put_OngoingOrder.feature.
        
        -------------------------------------------------------
        
        D: My views or queries for /v1/orders/{orderID}/complete - PUT :
        
        1. Please see feature file - api_put_CompleteOrder.feature.
        
        -------------------------------------------------------
        
        E: My views or queries for /v1/orders/{orderID}/cancel - PUT :
        
        1. Please see feature file - api_put_CompleteOrder.feature.
        
        
        **************************************************************
        **************************************************************
        
        
        
Background:
* def sleep = read('classpath:com/onenote/utilities/sleep.js')


############################################## Scenario One with complete order #########################################

#@scenarioWithCompleteOrder
#@ignore
Scenario Outline:


* def input_LatLng = <latitude_longitude>
* print "input_LatLng", input_LatLng

* def fileName = 'payload_placeOrder.json'


* def doWork =
							"""
								function(jsonFile, latitude_longitude) 
								{
  								var BreakTheStringInput = Java.type('com.onenote.utilities.BreakTheStringInput');
  								var listWithLatitudesAndLongitudes = BreakTheStringInput.coordinatesToSplit(latitude_longitude);
  								var Coordinates = Java.type('com.onenote.parsers.Coordinates');
  								var preparePayloadForOrderPlacing = Coordinates.latitudeAndLongitudeAppend(jsonFile,listWithLatitudesAndLongitudes )  	;
  								return preparePayloadForOrderPlacing;							
								}
							"""

* def returnFromdoWorkFunction = doWork( fileName, input_LatLng)

* print " payload from returnFromdoWorkFunction : ", returnFromdoWorkFunction


* json payloadForPlacingOrderInJson = returnFromdoWorkFunction
* print "payload from  returnFromdoWorkFunction :", payloadForPlacingOrderInJson



#####INFO: call /v1/orders with above payload #####

* def responseFromPlaceOrder = call read('classpath:com/onenote/api/api_post_placeOrder.feature') payloadForPlacingOrderInJson
* print "response_from_api_user :" , responseFromPlaceOrder

* json orderIDJSON = {orderId: '#(responseFromPlaceOrder.response.id)' }
* print "orderIDJSON :", orderIDJSON

#####INFO: call /v1/orders/{orderID} with above orderID in json #####

* def responseFromFetchOrder = call read('classpath:com/onenote/api/api_get_orderDetails.feature') orderIDJSON

#####INFO: call /v1/orders/{orderID}/take with above orderID in json #####

* def responseFromOngoingPUTOrder = call read('classpath:com/onenote/api/api_put_ongoingOrder.feature') orderIDJSON

#####INFO: call /v1/orders/{orderID}/complete with above orderID in json #####

* def responseFromCompletePUTOrder = call read('classpath:com/onenote/api/api_put_completeOrder.feature') orderIDJSON



Examples:
|     latitude_longitude                          												                      												                               		  |
|    'lat:22.344674_lng:114.124651#lat:22.375384_lng:114.182446#lat:22.385669_lng:114.186962' 	 										                                      |
#|    'lat:22.232524_lng:112.125854#lat:22.444555_lng:111.125854#lat:30.344555_lng:111.125854#lat:31.344555_lng:121.125854'                        			  |


############################################## Scenario One complete       ##############################################



############################################## Scenario Two with cancel order ###########################################

#@scenarioWithCancelOrder
#@ignore
Scenario Outline:

* def input_LatLng = <latitude_longitude>
* print "input_LatLng", input_LatLng

* def fileName = 'payload_placeOrder.json'


* def doWork =
							"""
								function(jsonFile, latitude_longitude) 
								{
  								var BreakTheStringInput = Java.type('com.onenote.utilities.BreakTheStringInput');
  								var listWithLatitudesAndLongitudes = BreakTheStringInput.coordinatesToSplit(latitude_longitude);
  								var Coordinates = Java.type('com.onenote.parsers.Coordinates');
  								var preparePayloadForOrderPlacing = Coordinates.latitudeAndLongitudeAppend(jsonFile,listWithLatitudesAndLongitudes )  	;
  								return preparePayloadForOrderPlacing;							
								}
							"""

* def returnFromdoWorkFunction = doWork( fileName, input_LatLng)

* print " payload from returnFromdoWorkFunction : ", returnFromdoWorkFunction

* print " payload from returnFromdoWorkFunction : ", returnFromdoWorkFunction
* json payloadForPlacingOrderInJson = returnFromdoWorkFunction
* print "payload from  returnFromdoWorkFunction :", payloadForPlacingOrderInJson


#####INFO: call /v1/orders with above payload #####

* def responseFromPlaceOrder = call read('classpath:com/onenote/api/api_post_placeOrder.feature') payloadForPlacingOrderInJson
* print "response_from_api_user :" , responseFromPlaceOrder

* json orderIDJSON = {orderId: '#(responseFromPlaceOrder.response.id)' }
* print "orderIDJSON :", orderIDJSON

#####INFO: call /v1/orders/{orderID} with above orderID in json #####

* def responseFromFetchOrder = call read('classpath:com/onenote/api/api_get_orderDetails.feature') orderIDJSON

#####INFO: call /v1/orders/{orderID}/take with above orderID in json #####

* def responseFromOngoingPUTOrder = call read('classpath:com/onenote/api/api_put_ongoingOrder.feature') orderIDJSON

#####INFO: call /v1/orders/{orderID}/cancel with above orderID in json #####

* def responseFromCancelPUTOrder = call read('classpath:com/onenote/api/api_put_cancelOrder.feature') orderIDJSON

Examples:
|     latitude_longitude                          												                      												                               		  |
|    'lat:22.232524_lng:112.125854#lat:22.444555_lng:111.125854#lat:30.344555_lng:111.125854#lat:31.344555_lng:121.125854'                        			  |
#|    'lat:22.344674_lng:114.124651#lat:22.375384_lng:114.182446#lat:22.385669_lng:114.186962' 	 										                                      |



############################################## Scenario Two complete         ##############################################										                                      |
