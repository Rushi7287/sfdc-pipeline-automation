import { LightningElement, track } from 'lwc';

export default class CertificatePopup extends LightningElement {
    static renderMode = 'light';
    @track visible = false;
    @track imgUrl = '';

    connectedCallback() {
        window.addEventListener('showcert', this.handleShow.bind(this));
    }

    handleShow(e) {
        const id = e.detail && e.detail.id;
        if (!id) return;
        this.imgUrl = '/sfc/servlet.shepherd/version/download/' + id;
        this.visible = true;
    }

    close() {
        this.visible = false;
    }
}