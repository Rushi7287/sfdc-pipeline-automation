import { LightningElement, track } from 'lwc';
// import getActiveItems from '@salesforce/apex/PortfolioDataController.getActiveItems';
// import getActiveCertificates from '@salesforce/apex/PortfolioDataController.getActiveCertificates';

export default class PortfolioMainPage extends LightningElement {
    static renderMode = 'light';
    @track projects = [];
    @track certificates = [];

    connectedCallback() {
        this.loadData();
    }

    loadData() {
        // getActiveItems({ typeDevName: 'Project' })
        //     .then(res => {
        //         this.projects = res.map(r => {
        //             r.imageUrl = r.contentVersionId ? '/sfc/servlet.shepherd/version/download/' + r.contentVersionId : null;
        //             return r;
        //         });
        //     }).catch(e => console.error(e));

        // getActiveCertificates()
        //     .then(res => {
        //         this.certificates = res.map(c => {
        //             c.imageUrl = c.contentVersionId ? '/sfc/servlet.shepherd/version/download/' + c.contentVersionId : null;
        //             return c;
        //         });
        //     }).catch(e => console.error(e));
    }

    handleProjectClick() {
        window.location.href = '/login?startURL=/s/projects';
    }

    showCert(e) {
        const id = e.currentTarget.dataset.id;
        const ev = new CustomEvent('showcert', { detail: { id } , bubbles: true});
        this.dispatchEvent(ev);
    }
}