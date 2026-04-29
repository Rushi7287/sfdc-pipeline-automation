import { LightningElement } from 'lwc';
import PROFILE_PIC from '@salesforce/resourceUrl/iconMy';

export default class Portfolio extends LightningElement {
    profileUrl = PROFILE_PIC;
    navItems = [
        { id: 'education', label: 'Education' },
        { id: 'experience', label: 'Experience' },
        { id: 'certificates', label: 'Certificates' },
        { id: 'contact', label: 'Contact' }
    ];

    handleScroll(event) {
        const targetId = event.target.dataset.target;
        const targetSection = this.template.querySelector(`[data-id="${targetId}"]`);
        
        if (targetSection) {
            targetSection.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    }
}