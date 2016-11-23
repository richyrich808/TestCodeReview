@isTest
private class TestWholesalePricingRequestExtension {

    static testmethod void TestCustomSave() {

        Wholesale_Pricing_Request__c wholesalePricingRequest = new Wholesale_Pricing_Request__c();
        wholesalePricingRequest.Pricing__c = 'BESPOKE PRICING';
        wholesalePricingRequest.Bespoke_Requirement__c = 'New Combined Service Pool (CSP)';
        wholesalePricingRequest.Product_Impact__c = 'GX';
        wholesalePricingRequest.Cross_BU_Engagement__c = 'Yes';
        wholesalePricingRequest.Group_Pricing_BU__c = 'Financial Analysis';
        wholesalePricingRequest.Name = 'testName';
        wholesalePricingRequest.Proposed_By__c = 'Maritime';
        wholesalePricingRequest.Proposed_By_User__c = getUserId();
        wholesalePricingRequest.Expected_CSI_Date__c = '1234';
        wholesalePricingRequest.Rational__c = 'test';
        wholesalePricingRequest.Agreed__c = System.today();
        wholesalePricingRequest.COMPETITOR_INTELLIGENCE_ATTACHED__c = 'Yes';
        wholesalePricingRequest.MARKET_INTELLIGENCE_ATTACHED__c = 'Yes';
        wholesalePricingRequest.Group_Pricing__c = 'Agree Next Step';
        wholesalePricingRequest.Confirmed_CSI_Date__c = '1234';
        wholesalePricingRequest.CONTRACTS_LEGAL_IMPACT__c = 'New Bespoke';
        wholesalePricingRequest.BSS_Impact__c = 'No changes required';
        wholesalePricingRequest.Confirmed_Date__c = System.today();
        wholesalePricingRequest.Detail__c = '1234';
        wholesalePricingRequest.GX_REQUIREMENT__c = 'GX SSP';
        wholesalePricingRequest.PARTNER_s_IMPACTED__c = 'Yes';
        wholesalePricingRequest.Existing__c = 'Yes';
        wholesalePricingRequest.TOTAL_VALUE_OF_CSP_COMMITMENT__c = 1232;
        wholesalePricingRequest.PRODUCTS_REQUIRED_FOR_CSP__c = 'SMS';
        wholesalePricingRequest.TERM_OF_CSP_COMMITMENT_MONTHS__c = 2;
        wholesalePricingRequest.REQUESTED_DISCOUNTED_SERVICES__c = 'BGAN';
        wholesalePricingRequest.APPROVED_BY_ALL_IMPACTED_BUs__c = 'Yes';
        wholesalePricingRequest.Requirement_Lead__c = 'Complete';


        insert wholesalePricingRequest;

    	ApexPages.standardController stController = new ApexPages.standardController(wholesalePricingRequest);
    	wholesalePricingRequestExtension wp = new wholesalePricingRequestExtension(stController);

    	PageReference pageRef = new PageReference('/apex/vfpage');
    	pageRef.getParameters().put('id', String.valueOf(wholesalePricingRequest.Id));
    	Test.setCurrentPage(pageRef);

    	wp.customSave();
    	wp.doCancel();
    }

    static testmethod void TestCustomSaveWithErrors() {

        Wholesale_Pricing_Request__c wholesalePricingRequest = new Wholesale_Pricing_Request__c();
        wholesalePricingRequest.Name = 'testName';

        //insert wholesalePricingRequest;

    	ApexPages.standardController stController = new ApexPages.standardController(wholesalePricingRequest);
    	wholesalePricingRequestExtension wp = new wholesalePricingRequestExtension(stController);

    	PageReference pageRef = new PageReference('/apex/vfpage');
    	pageRef.getParameters().put('id', String.valueOf(wholesalePricingRequest.Id));
    	Test.setCurrentPage(pageRef);

    	wp.addErrorMessage('test');

    	wp.customSave();
    }

    static Id getUserId() {

    	Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 

        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser4354365345756@example.com');
        insert u;
        System.debug(u.Id);
        return u.Id;
    }
}