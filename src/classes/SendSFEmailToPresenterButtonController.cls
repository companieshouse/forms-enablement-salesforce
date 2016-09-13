public with sharing class SendSFEmailToPresenterButtonController {

    private ApexPages.StandardController standardController;
    
    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public SendSFEmailToPresenterButtonController(ApexPages.StandardController stdController) {
        standardController = stdController;
    }

    public PageReference initButton() {
        
        //Return to the page
        PageReference pg = new PageReference('/apex/SendSFEmailToPresenter');
        pg.getParameters().put('id', standardController.getId());
        pg.setRedirect(true);
        return pg;
    }
}