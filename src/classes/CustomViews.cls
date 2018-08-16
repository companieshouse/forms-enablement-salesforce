/*
Name:  CustomViews.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

CustomViews as String
--simple way to get around metadata character limitations
======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Leo Bitoy   2016-06-23  Initial development.

*/
public with sharing class CustomViews {

		public final static String SH19_REVIEW_PAGE =  ' <div class="govuk-form-group"> <table class="check-your-answers"> <thead> <tr> <th colspan="4">Statement of Capital </th> </tr></thead> <tbody> <tr> <td>Currency</td><td>Class of shares</td><td>No. of shares</td><td>Total value aggregate</td></tr><br/> <apex:repeat value="{!reviewShares}" var="sp" id="theRepeat"> <tr> <td> <apex:outputText value="{!sp.Currency__c}" id="currency"/> </td><td> <apex:outputText value="{!sp.Class_of_Shares__c}" id="shareclass"/> </td><td> <apex:outputText value="{!sp.Number_of_Shares__c}" id="numberofshares"/> <input type="hidden" value="{!sp.Number_of_Shares__c}" name="numid" id="shareidentifier"/> </td><td> <apex:outputText value="{!sp.Aggregate_nominal_value__c}" id="aggregate"/> <input type="hidden" value="{!sp.Aggregate_nominal_value__c}" name="numid" id="aggregateidentifier"/> </td></tr></apex:repeat> <tr> <td></td><td>Total</td><td id="totalnumberofshares"></td><td id="totalnumberaggregate"></td><td></td></tr></tbody> </table> </div><script>function numberofshares(){var sharesum=0; var aggsum=0; var shareparsed=""; var aggparsed=""; var values=document.getElementsByTagName("input"); window.sharesvariable=values; for (var i=0; i < values.length; i++){if (values[i].id=="shareidentifier"){shareparsed=values[i].value; sharesum=sharesum + parseInt(shareparsed);}else if (values[i].id=="aggregateidentifier"){aggparsed=values[i].value; aggsum=aggsum + parseInt(aggparsed);}}document.getElementById("totalnumberofshares").innerHTML=sharesum; document.getElementById("totalnumberaggregate").innerHTML=aggsum;} numberofshares(); </script> <br/>';

	
}