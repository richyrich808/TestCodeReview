public class wholesalePricingRequestDetails {

    private final Wholesale_Pricing_Request__c wholesalePricingRequest;
    public String idRequest { get; set; }

    public wholesalePricingRequestDetails(ApexPages.StandardController controller) {
        this.wholesalePricingRequest = (Wholesale_Pricing_Request__c)controller.getRecord();
        

        idRequest = ApexPages.currentPage().getParameters().get('id');
        
    }

}