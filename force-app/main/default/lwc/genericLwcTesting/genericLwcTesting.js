import { LightningElement, track } from 'lwc';
import PROFILE_PIC from '@salesforce/resourceUrl/iconMy';
import { loadStyle } from 'lightning/platformResourceLoader';
import FONT_STYLE from '@salesforce/resourceUrl/Preahvihear';
import BACKGROUND_IMAGE from '@salesforce/resourceUrl/MyBackgroundImage';

export default class NavBar extends LightningElement {
    profileUrl = PROFILE_PIC;
    renderedCallback() {

        loadStyle(this, FONT_STYLE)
            .then(() => {
                console.log('Google Font loaded successfully');
            })
            .catch(error => {
                console.error('Error loading font', error);
            });
    }

    get backgroundStyle() {
        return `background-image: url(${BACKGROUND_IMAGE});`;
    }
    
}