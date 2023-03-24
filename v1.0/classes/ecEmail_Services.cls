/* Author:- Vishnu Pillai(©vishnuvpinfo@gmail.com)
 * Description:- This class is used to Send email when ecEmail__c record is recorded.
 * emailPostman --> This function is used to send Single email to the recpective Recipients using Messaging class.
 * addressbook  --> This function is used to segrigate Recipients from string to List.
 */

public class ecEmail_Services {
    public static Boolean emailPostman (List<ecEmail__c> letters){
		Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        EC_Email_Setting__mdt settings = EC_Email_Setting__mdt.getInstance('Default');
        for(ecEmail__c letter: letters){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        	email.setToAddresses(ecEmail_Services.addressbook(letter.TO__c));
        	email.setOrgWideEmailAddressId('0D22w000000TQHm');// Need to make it dynamic.
        	email.setSubject(letter.Subject__c);
       		email.setHtmlBody(letter.Body__c);
            messages.add(email);
        }
        try{
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            
        }catch(exception e){
            System.debug(e.getMessage());
            return false;
        }
        return true;
    }
    public static List<String> addressbook(String recipients){
        List<String> recipientlist = new List<String>();
        Decimal semicol = recipients.countMatches(';');
        for(Decimal i=0; i< semicol; i++){
            String dummy = recipients.substringBefore(';');
            dummy = dummy.deleteWhitespace();
            recipients = recipients.substringAfter(';');
            if(dummy == null || dummy == ''){
                System.debug('Null Value present!');
            }
            else{
                recipientlist.add(dummy);
            }
        }
        if(recipients == null || recipients == ''){
            System.debug('Null Value present!');
        }
        else{
            recipientlist.add(recipients.deleteWhitespace());
        }
        return recipientlist;
    }
}