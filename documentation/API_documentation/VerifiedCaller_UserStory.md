# Verified Caller API User Story

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an enterprise application developer, I want to be able to display brand card messages via this API to a called user so that to improve the connection rate.
| ***Actors and Scope*** | **Actors:** Application service provider (ASP), ASP:User, ASP:Administrator, Channel Partner, Communication Service Provider (CSP). <br> **Scope:**  <br> -Sending the brand card to called users. |
| ***Pre-conditions*** |The preconditions are as follows:<br/><ol><li> The  ASP:Administrator has been onboarded to the CSP's API platform via (or not) a Channel Partner.</li><li> The ASP:Administrator has onboarded the ASP:User to the platform.</li><li> The ASP:User performs an authorization request to CSP.</li><li> The CSP checks ASP:User phone number then provides access token to the ASP:User.</li><li> The ASP:User gets the access token, via (or not) the Channel Partner, allowing a secure access of the API.</li></ol> |
| ***Activities/Steps*** | **Starts when:** The Channel Partner sends a POST request via the Verified Caller API, including the ASP:User phone number and the operation to be performed (sending SMS) for displaying the brand card of ASP:User.<br>**Ends when:** The CSP's Verified Caller server responds with the status of the POST request, then informs to ASP:Administrator via (or not) the Channel Partner. |
| ***Post-conditions*** | The ASP:User could continue to use the Verified Caller service to call users via the ASP:Administrator with confirmation of Verified Caller server's successful response.  |
| ***Exceptions*** | The following several abnormal situations may occur during the VerifiedCaller subscription operation:<br/>-Unauthorized: Invalid credentials (for example, using an expired access token).<br/>-Invalid Input: The parameter fails the specification check (for example, the phone number is too long or incorrect).<br/>-Not able to provide: Legal restrictions or data retention policies preventing the retrieval of the requested information.  |                        

