Feature:

############################################## Scenario One with complete order #########################################


Background:
* def sleep = read('classpath:com/onenote/utilities/sleep.js')


@scenarioWithCompleteOrder
@ignore
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

@scenarioWithCancelOrder
@ignore
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
