import { LightningElement, api, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import EMAIL_OBJECT from '@salesforce/schema/EC_Email__c';
import TO_FIELD from '@salesforce/schema/EC_Email__c.TO__c';
//import CC_FIELD from '@salesforce/schema/EC_Email__c.AnnualRevenue';
import SUBJECT_FIELD from '@salesforce/schema/EC_Email__c.Subject__c';
import BODY_FIELD from '@salesforce/schema/EC_Email__c.Body__c';

export default class EC_Email_Backend extends LightningElement {
    @api EC_Email__c;
    @api emaildata;
    emailId;

    
    handleSend(event) {
            console.log('Event Received!');
            const fields = {};
            fields[TO_FIELD.fieldApiName] = this.emaildata.to;
            fields[SUBJECT_FIELD.fieldApiName] = this.emaildata.subject;
            fields[BODY_FIELD.fieldApiName] = this.emaildata.body;
            console.log(JSON.stringify(fields));
            const recordInput = { apiName: EMAIL_OBJECT.objectApiName , fields };
            createRecord(recordInput)
                .then(emailrec => {
                    this.emailId = emailrec.id;
                    console.log('Record created');
                })
                .catch(error => {
                    console.log('Error on record creation');
                });
    }


}