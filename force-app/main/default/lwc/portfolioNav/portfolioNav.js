import { LightningElement, track } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import FONT_STYLE from '@salesforce/resourceUrl/Preahvihear';
import PROFILE_PIC from '@salesforce/resourceUrl/MyProfilePhoto';

export default class NavBar extends LightningElement {
    @track isMenuOpen = false;
    @track isOpen = false;
    profileUrl = PROFILE_PIC;

    name = 'Rushikesh Kale';
    company = 'Bajaj Finserv';
    about = 'Passionate Software Developer and Designer.';
    email = 'rushikeshkale7287@gmail.com';
    mobile = '+91 7972391051';

    @track isVisible = false;

    get cardClass() {
        return this.isVisible ? 'profile-card show' : 'profile-card';
    }

    togglePopup() {
        this.isVisible = !this.isVisible;
    }

    get menuClassH() {
        return this.isMenuOpen ? 'nav-links active' : 'nav-links';
    }

    get menuClassF() {
        return this.isOpen ? 'menu-panel active' : 'menu-panel';
    }

    get buttonClass() {
        return this.isOpen ? 'fab-button active' : 'fab-button';
    }

    renderedCallback() {
        document.querySelectorAll('div').forEach(element => {
            if (element.classList[0] == "cCenterPanel" || element.classList[0] == "slds-col--padded") {
                element.removeAttribute('class');
            }
        })
        loadStyle(this, FONT_STYLE)
            .then(() => {
                console.log('Google Font loaded successfully');
            })
            .catch(error => {
                console.error('Error loading font', error);
            });
    }

    disconnectedCallback() {
        document.body.style.overflow = 'auto';
    }

    toggleMenu() {
        this.isMenuOpen = !this.isMenuOpen;
        if (this.isMenuOpen) {
            document.body.style.overflow = 'hidden';
        } else {
            document.body.style.overflow = 'auto';
        }
    }

    handleMenuClick(event) {
        const name = event.currentTarget.dataset.name;
        console.log('Clicked item:', name);
        this.isOpen = false;
    }

    toggleMenuFloat() {
        this.isOpen = !this.isOpen;
    }
}