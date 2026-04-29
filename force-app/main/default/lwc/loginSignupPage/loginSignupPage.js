import { LightningElement, track } from 'lwc';
import registerUser from '@salesforce/apex/AuthController.register';
import loginUser from '@salesforce/apex/AuthController.login';
import sendOtp from '@salesforce/apex/AuthController.sendOtp';
import verifyOtpAndReset from '@salesforce/apex/AuthController.verifyOtpAndReset';

export default class LoginSignupPage extends LightningElement {
    static renderMode = 'light';
    @track mode = 'login';
    @track loginUsername=''; loginPassword='';
    @track regUsername=''; regEmail=''; regPassword=''; regRePassword='';
    @track otpUsernameOrEmail=''; otpValue=''; newPassword=''; newRePassword='';

    showError(msg) { alert(msg); }

    handleLogin() {
        if (!this.loginUsername || !this.loginPassword) { this.showError('Enter username and password'); return; }
        loginUser({ username: this.loginUsername, passwordPlain: this.loginPassword })
            .then(res => {
                if (res.success) {
                    this.dispatchEvent(new CustomEvent('loginsuccess',{detail:{userId:res.userId}}));
                    window.location.href = '/s/projects';
                } else {
                    this.showError(res.message || 'Login failed');
                }
            }).catch(err => this.showError(err.body ? err.body.message : err.message));
    }

    handleRegister() {
        if (!this.regUsername || !this.regEmail || !this.regPassword || !this.regRePassword) { this.showError('Fill all fields'); return; }
        if (this.regPassword !== this.regRePassword) { this.showError('Passwords do not match'); return; }
        registerUser({ username: this.regUsername, email: this.regEmail, passwordPlain: this.regPassword })
            .then(res => {
                alert('Registration successful. Please login.');
                this.mode='login';
            }).catch(err => this.showError(err.body ? err.body.message : err.message));
    }

    handleSendOtp() {
        if (!this.otpUsernameOrEmail) { this.showError('Enter username or email'); return; }
        sendOtp({ usernameOrEmail: this.otpUsernameOrEmail })
            .then(() => { alert('OTP sent to your email'); this.mode='reset'; })
            .catch(err => this.showError(err.body ? err.body.message : err.message));
    }

    handleResetPass() {
        if (!this.otpValue || !this.newPassword || !this.newRePassword) { this.showError('Enter OTP and new password'); return; }
        if (this.newPassword !== this.newRePassword) { this.showError('Passwords do not match'); return; }
        verifyOtpAndReset({ usernameOrEmail: this.otpUsernameOrEmail, otp: this.otpValue, newPass: this.newPassword })
            .then(() => { alert('Password reset successful. Login.'); this.mode='login'; })
            .catch(err => this.showError(err.body ? err.body.message : err.message));
    }
}