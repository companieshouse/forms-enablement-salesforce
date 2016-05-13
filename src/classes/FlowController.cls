public class FlowController {

	String accountId;
	String flowOutput;

	public FlowController(){
		flowOutput = Apexpages.currentPage().getParameters().get('output');
		System.debug('CONS '+ flowOutput);
	}

	public PageReference getEndPage() {
		PageReference pageRef;

		if (flowOutput == 'IncorrectDirectors')
			pageRef = new Pagereference ('/00558000000fEQX'); //ab to be update
		if (flowOutput == 'Payment')
			pageRef = new Pagereference('/PaymentPage');

	return pageRef;
	}
}