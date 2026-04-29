import { LightningElement, track } from 'lwc';
export default class VideoStreamingApp extends LightningElement {
    @track videoURL = "https://www.youtube.com/embed/RgzLnmTaCAU?si=HEz_1zdnOicccfOK&amp";
    @track timer = 0;
    // connectedCallback() {
    //     this.videoURL = "https://www.youtube.com/embed/RgzLnmTaCAU?si=HEz_1zdnOicccfOK&amp;start=" + this.timer;
    // }

    changeTimer = () => {
        console.log('ie aldj f');
        //this.videoURL = "https://www.youtube.com/embed/RgzLnmTaCAU?si=HEz_1zdnOicccfOK&amp;start=96";
    }

}