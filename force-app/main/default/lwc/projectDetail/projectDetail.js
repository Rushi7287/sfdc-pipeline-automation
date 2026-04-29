import { LightningElement, api, track } from 'lwc';
import getActiveItems from '@salesforce/apex/PortfolioDataController.getActiveItems';

export default class ProjectDetail extends LightningElement {
    static renderMode = 'light';
    @api recordId;
    @track project;

    connectedCallback() {
        // simple loader - in real use, create separate Apex method to get by Id
    }
}