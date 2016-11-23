trigger Opp_P_win_and_P_go_UpdatePDS on PDS_OISM__Partner_Sheet__c (after insert, after update) {

    List<Opportunity> oppList = new List<Opportunity>();
    
    for(PDS_OISM__Partner_Sheet__c pds : Trigger.New) {
        if (pds.PDS_OISM__Opportunity__c != null && pds.PDS_OISM__Why_Buy_Percentage_Score__c != null &&
            pds.PDS_OISM__What_Do_Percentage_Score__c != null && pds.PDS_OISM__Why_You_Percentage_Score__c != null) {
        
                oppList.add(new Opportunity(Id = pds.PDS_OISM__Opportunity__c,
                							P_go__c = pds.PDS_OISM__Why_Buy_Percentage_Score__c,
                	                   		P_win__c = (pds.PDS_OISM__What_Do_Percentage_Score__c + 
                                                        pds.PDS_OISM__Why_You_Percentage_Score__c)/2 ));
                
                System.debug('Id = ' + pds.PDS_OISM__Opportunity__c + ', P_go__c = ' + 
                         	 pds.PDS_OISM__Why_Buy_Percentage_Score__c + ', P_win__c = ' + 
                         	 (pds.PDS_OISM__What_Do_Percentage_Score__c + pds.PDS_OISM__Why_You_Percentage_Score__c)/2);
            }
        else {
            // show which value might be null
			System.debug('pds.PDS_OISM__Opportunity__c = ' + pds.PDS_OISM__Opportunity__c + 
                         ', pds.PDS_OISM__Why_Buy_Percentage_Score__c = ' + pds.PDS_OISM__Why_Buy_Percentage_Score__c +
                         ', pds.PDS_OISM__What_Do_Percentage_Score__c = ' + pds.PDS_OISM__What_Do_Percentage_Score__c + 
                         ', pds.PDS_OISM__Why_You_Percentage_Score__c = ' + pds.PDS_OISM__Why_You_Percentage_Score__c);
        }

    }
    
    if (oppList.size() > 0) {
        update oppList;
    }
}