@isTest
private class testOpp_P_win_and_P_go_Update {
    
    static testmethod void testP_win_and_P_go_Update() {
        
        Id oppId = createOpp();
        
        OISM__Deal_Sheet__c ds = new OISM__Deal_Sheet__c(Name = 'test Name',
                                                         OISM__Opportunity__c = oppId,
                                                         OISM__X_asix_Quadrant__c = 47,
                                                         OISM__Y_axis_Quadrant__c = 38);
        insert ds;
    }

    static Id createOpp() {
        Opportunity opp = new Opportunity(Name = 'test Name', StageName = '1 - Prospecting', CloseDate = Date.today());
        insert opp;
        //System.debug('opp Id = ' + opp.Id);
        return opp.Id;
    }
}