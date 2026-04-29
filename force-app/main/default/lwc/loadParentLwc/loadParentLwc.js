import { LightningElement, wire } from 'lwc';
import { loadStyle , loadScript} from 'lightning/platformResourceLoader';
import TAILWIND from '@salesforce/resourceUrl/tailwind';
import BOOTSTRAP from '@salesforce/resourceUrl/bootstrap';
import { getRecordUi } from 'lightning/uiRecordApi';



export default class LoadParentLwc extends LightningElement {
}