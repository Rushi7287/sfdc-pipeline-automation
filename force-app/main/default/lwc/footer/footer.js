import { LightningElement } from 'lwc';
export default class Footer extends LightningElement {

}


// curl --location 'https://dev.azure.com/BFLDevOpsOrg/B2B_Projects/_apis/wit/wiql?api-version=7.0&%24top=10' \
// --header 'Authorization: Basic OkRVSm5OdUtwUkx2QXhLV3RWN2c4SUQzOWdadkEyMm12YjAxclptMHFPQ2NydzhPRDZZTWNKUVFKOTlCTEFDQUFBQUFPMlM3WEFBQVNBWkRPMzRocQ==' \
// --header 'Content-Type: application/json' \
// --header 'Cookie: VstsSession=%7B%22PersistentSessionId%22%3A%223c557a45-fed9-45f7-879b-fd23f85acce2%22%2C%22PendingAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22CurrentAuthenticationSessionId%22%3A%2200000000-0000-0000-0000-000000000000%22%2C%22SignInState%22%3A%7B%7D%7D; __RequestVerificationToken=GDvtAPn41Ju_bV84VhfSzOR9fdYBKopyjh_zKCm4NmqpZZ9OiWhSnDjPOcunFL3voo_mWE8-2sKjWr89Njwzgj_GBlS91QtaIjQHiexz3NQ1; __RequestVerificationToken2fe69ddff-c1dc-4720-a76d-5cf043a74fa8=GDvtAPn41Ju_bV84VhfSzOR9fdYBKopyjh_zKCm4NmqpZZ9OiWhSnDjPOcunFL3voo_mWE8-2sKjWr89Njwzgj_GBlS91QtaIjQHiexz3NQ1' \
// --data '{
//   "query": "SELECT [System.Id], [System.Title], [System.State], [System.ChangedDate] FROM workitems WHERE [System.Id] = '\''7923033'\''"
// }'