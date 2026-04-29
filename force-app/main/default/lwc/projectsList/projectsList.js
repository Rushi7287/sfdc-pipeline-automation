import { LightningElement, track } from 'lwc';
import getActiveItems from '@salesforce/apex/PortfolioDataController.getActiveItems';

export default class ProjectsList extends LightningElement {
    static renderMode = 'light';
    @track projects = [];

    connectedCallback() {
        this.load();
    }

    load() {
        getActiveItems({ typeDevName: 'Project' })
            .then(res => {
                this.projects = res.map(r => {
                    r.imageUrl = r.contentVersionId ? '/sfc/servlet.shepherd/version/download/' + r.contentVersionId : null;
                    return r;
                });
            }).catch(e => console.error(e));
    }

    openProject(e) {
        // navigate to detail - ensure user logged in or use server-side login
        const id = e.currentTarget.dataset.id;
        window.location.href = '/s/project?id=' + id;
    }
}