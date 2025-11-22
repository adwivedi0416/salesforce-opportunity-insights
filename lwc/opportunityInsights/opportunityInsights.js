import { LightningElement, api, track } from 'lwc';
import calculateScore from '@salesforce/apex/OpportunityScoreCalculator.calculateScore';

export default class OpportunityInsights extends LightningElement {
    @api recordId;
    @track score;

    connectedCallback() {
        calculateScore({ oppId: this.recordId })
            .then(result => { this.score = result.score; });
    }
}
