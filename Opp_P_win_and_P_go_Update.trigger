trigger Opp_P_win_and_P_go_Update on OISM__Deal_Sheet__c (after insert, after update) {

    List<Opportunity> oppList = new List<Opportunity>();
    
    for(OISM__Deal_Sheet__c ds : Trigger.New) {
        if (ds.OISM__Opportunity__c != null && ds.OISM__X_asix_Quadrant__c != null && ds.OISM__Y_axis_Quadrant__c != null) {
            
            oppList.add(new Opportunity(Id = ds.OISM__Opportunity__c,
                                        P_go__c = ds.OISM__X_asix_Quadrant__c,
                                        P_win__c = ds.OISM__Y_axis_Quadrant__c));
            
            System.debug('Id = ' + ds.OISM__Opportunity__c + ', P_go__c = ' + ds.OISM__X_asix_Quadrant__c +
                         ', P_win__c = ' + ds.OISM__Y_axis_Quadrant__c);
        }
        else {
            // show where is null
            System.debug('ds.OISM__Opportunity__c = ' + ds.OISM__Opportunity__c + 
                         ', ds.OISM__X_asix_Quadrant__c = ' + ds.OISM__X_asix_Quadrant__c +
                         ', ds.OISM__Y_axis_Quadrant__c = ' + ds.OISM__Y_axis_Quadrant__c);
        }
    }
    
    if (oppList.size() > 0) {
        update oppList;
    }
}