## Introduction

## Problem Statement

There are APIs to process orders and my job is to make sure it's functioning correctly with black box testing. The API does these tasks:
1. Place Order
2. Fetch Order Details
3. Driver to Take the Order
4. Driver to Complete the Order
5. Cancel Order

## Order Flow

An order has these statuses in sequence: `ASSIGNING` => `ONGOING` => `COMPLETED` or `CANCELLED`
   - `ASSIGNING`: looking for a driver to be assigned
   - `ONGOING`: a driver has been assigned and working on the order
   - `COMPLETED`: the driver has completed the order
   - `CANCELLED`: the order was cancelled
   
   
   - The following API's been tested:
    
<table>
<tr>
 <th>POST</th>
 <td>/v1/orders </td>
</tr>
<tr>
<th>GET</th>
 <td>/v1/orders/{orderID} </td>
</tr>
<tr>
<th>PUT</th>
 <td>/v1/orders/{orderID}/take </td>
</tr> 
<tr>
<th>PUT</th>
 <td>/v1/orders/{orderID}/cancel </td>
</tr>   
<tr>
<tr>
<th>PUT</th>
 <td>/v1/orders/{orderID}/complete </td>
</tr>   
<tr>
&nbsp;&nbsp;</table>
  <br/><br/> 
This work is adopted using [Karate unified test automation framework](https://github.com/intuit/karate).

## To execute this project:

Please clone the project or download and follow below information to move further on execution.

```
STEP 1: scenarios in `e2e_orderflow.feature` - Scenario One with complete order and Scenario two with cancel order
STEP 2: there are two scenario's in `e2e_orderflow.feature` and you can choose to run one or both.
STEP 3: if you want execute scenarios then make sure there is `#` before the tags `@scenarioWithCompleteOrder` and `@ignore` for first scenario.
STEP 4: if you want execute both then make sure you repeat `STEP 3`, note in scenario you will see tags `scenarioWithCancelOrder` and `@ignore` .
STEP 5: you can use `mvn clean package compiler:testCompile surefire:test` .
```

## Output Report:

Please navigate to `target` folder in project location and open `cucumber-html-reports` folder and open `overview-features` html file.

## My thoughts on work:

1. Tried to keep it as simple as possible, because I want to have reusability and less maintanence.
2. There might one `javascript function` with in scenario steps I might repeat or unnecessarily duplicated in both scenarios, this can be moved to `reusable.js` or something like that.
3. And some places I have java code and I want this to be as simple as possible and keep reusing it where necessary with in scenario steps. Java is used very little. 
4. To validate date and time that is in response of - order placing, order assigning, order ongoing , order completed - we can use java class with method 
   having `simpledateformat` and other classes and that can called in scenario to test or validate the date and time.
4. The structure of this work - there will be calling feature and called feature, meaning all api's are in called feature (in respective files) and
   calling feature `e2e_orderflow.feature` is in its package.
   
## Things I have not tested, please see below.

   >> Due to too much time demanding and workload pressure from my regular day job, I had to skip few validations.

1. Firstly, due to too much work in day job I didn't get much time to test every single requirement.
2. Missed testing future order.
2. Missed testing 400 or 402, in other words when order doesn't exist we have to verify it gives necessary status code as stated in requirement.


:pray: Appreciated if someone contacts me to know much about my experience and skill set.



<br/>

  




