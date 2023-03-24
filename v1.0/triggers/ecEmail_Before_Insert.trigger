/* Author:- Vishnu Pillai(©vishnuvpinfo@gmail.com)
 * Description:- This trigger is used to invoke helper class ecEmail_Services when new ecEmail__c record is being inserted.
 */

trigger ecEmail_Before_Insert on ecEmail__c (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            Boolean isMailsend = ecEmail_Services.emailPostman(Trigger.new);
            if(isMailsend){
                System.debug('Succesfully mail Send!');
            }
            else{
                ecEmail__c error = new ecEmail__c();
                error.addError('Failed to send mail!');
            }
        }
    }
}