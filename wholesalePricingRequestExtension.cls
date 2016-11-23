public with sharing class wholesalePricingRequestExtension {

    Wholesale_Pricing_Request__c wholesalePricingRequest;
    ApexPages.standardController stController;
    List<String> requiredFieldsList = new List<String> { 'Name', 'Product_Impact__c', 'Proposed_By__c', 'Proposed_By_User__c', 'Pricing__c',
        												'Rational__c', 'Agreed__c', 'COMPETITOR_INTELLIGENCE_ATTACHED__c', 'MARKET_INTELLIGENCE_ATTACHED__c' };
    List<String> requiredFieldsListGX = new List<String> { 'GX_REQUIREMENT__c' };
    List<String> requiredFieldsListBespokePricing = new List<String> { 'PARTNER_s_IMPACTED__c' };
    List<String> requiredFieldsListStandardCSP = new List<String> { 'Existing__c', 'TOTAL_VALUE_OF_CSP_COMMITMENT__c', 'PRODUCTS_REQUIRED_FOR_CSP__c', 
        															'TERM_OF_CSP_COMMITMENT_MONTHS__c', 'REQUESTED_DISCOUNTED_SERVICES__c' };
    List<String> CrossBUEngagementEqualsYes = new List<String> { 'APPROVED_BY_ALL_IMPACTED_BUs__c' };
	List<String> GroupPricingBUAgreedStandardReqNotNull = new List<String> { 'Requirement_Lead__c' };

    String[] errorMessages = new List<String>();

    public void addErrorMessage(String newMessage) {
        errorMessages.add(newMessage);
    }

    public wholesalePricingRequestExtension(ApexPages.StandardController controller) {
    
        stController = controller;
        wholesalePricingRequest = (Wholesale_Pricing_Request__c)controller.getRecord();
    }
    
    public PageReference doCancel() {
        
        return stController.cancel();
    }
    
    public PageReference customSave() {
        
        /*String temp = String.valueOf(mandatoryFieldsNotBlank());
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, temp);
        ApexPages.addMessage(myMsg); */
        
          // if false then no errors
        if(mandatoryFieldsNotBlank()) {
            return stController.save();
        }
        else {
            System.debug('else ' + errorMessages.size());
            for (String error : errorMessages) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, error));
                System.debug('for ' + errorMessages);
            }
            errorMessages.clear();
            return null; 
        }

    }
    
    private Boolean mandatoryFieldsNotBlank() {
    
        Boolean noBlankFields;
        
        	// Checks all the mandatory fields who are permamently visible
        checkFieldsList(requiredFieldsList);
        
        	// Checks if Bespoke Detail section mandatory fields are not empty
        if (wholesalePricingRequest.Pricing__c == 'BESPOKE PRICING') {
            checkFieldsList(requiredFieldsListBespokePricing);
        }
        
        if (wholesalePricingRequest.Bespoke_Requirement__c == 'Renew Combined Service Pool (CSP)'
            || wholesalePricingRequest.Bespoke_Requirement__c == 'New Combined Service Pool (CSP)') {
            checkFieldsList(requiredFieldsListStandardCSP);
        }
        
        if (wholesalePricingRequest.Product_Impact__c != null && wholesalePricingRequest.Product_Impact__c.contains('GX')) {
            checkFieldsList(requiredFieldsListGX);
        }
        
        if (wholesalePricingRequest.Cross_BU_Engagement__c == 'Yes') {
            checkFieldsList(CrossBUEngagementEqualsYes);
        }
        
        if (wholesalePricingRequest.Group_Pricing_BU__c != null) {
            checkFieldsList(GroupPricingBUAgreedStandardReqNotNull);
        }
        
        if (errorMessages.size() > 0) {
            noBlankFields = false;
            System.debug(errorMessages.size());
        }
        else if (errorMessages.size() == 0) {
            noBlankFields = true;
            System.debug(errorMessages.size());
        }
        //else {
        //    System.debug('This is not supposed to happen.');
        //    noBlankFields = false;
        //}
            
        return noBlankFields;
    }
    
    public void checkFieldsList(List<String> fieldsList) {
        
        String fieldLabel;
        
		for (String fieldAPIName : fieldsList) {
            if (wholesalePricingRequest.get(fieldAPIName) == null || String.valueOf(wholesalePricingRequest.get(fieldAPIName)) == '') {
                fieldLabel = String.valueOf(Schema.getGlobalDescribe().get('Wholesale_Pricing_Request__c')
                                            .getDescribe().fields.getMap().get(fieldAPIName).getDescribe().getLabel());
                String errorMsg = String.valueOf('\'' + fieldLabel + '\' field cannot be empty.');
                errorMessages.add(errorMsg);
            }
        }
    }

}