@isTest
private class testOpp_P_win_and_P_go_UpdatePDS {

    static testmethod void testP_win_and_P_go_Update() {
        
        Id oppId = createOpp();
        
        PDS_OISM__Partner_Sheet__c pds = new PDS_OISM__Partner_Sheet__c(Name = 'test Name',
                                                         PDS_OISM__Opportunity__c = oppId,
                                                         PDS_OISM__Why_Buy_Percentage_Score__c = 47,
                                                         PDS_OISM__What_Do_Percentage_Score__c = 38,
                                                         PDS_OISM__Why_You_Percentage_Score__c = 11);
        insert pds;
    }

    static Id createOpp() {
        Opportunity opp = new Opportunity(Name = 'test Name', StageName = '1 - Prospecting', CloseDate = Date.today());
        insert opp;
        //System.debug('opp Id = ' + opp.Id);
        return opp.Id;
    }
}