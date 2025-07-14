
**User Story: Verified Caller - Registration**
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to register the display name to be announced for specified caller phone number in the Calling ID solution that I want to use.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Mobile Network Operators (MNO), Onboarding/Vetting authority, application developers, enterprise. <br> **Scope:**  |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has provided mandatory information of their identity</li><li>Application developer has onboarded to MNO API</li><li>Application developer has API credentials</li></ol>|
| ***Activities/Steps*** | **Starts when:** The aggregator collect information (display names, phone numbers) and makes a request to the Verified Caller service (API) to register the caller information.<br>**Ends when:** The MNO service returns an register id or an error.<br> |
| ***Post-conditions*** | Branded information are verified and can be approved or rejected. The application developer can make decision to use this customer data to follow-up enterprise processes.|
| ***Exceptions*** | Several exceptions might occur during the Verified Caller API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Phone number already used by another customer</li><li>Invalid input: Not all mandatory  input data to invoke operation (e.g. phone number).</li></ul>|

**User Story: Verified Caller - Pre-authorization (i.e. Pre-announcement)** 
<br>

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As an application developer belonging to an enterprise, I want to make my call verified and make the calling id solution displaying a branded announcement previously registered.  |
| ***Roles, Actors and Scope*** | **Roles:** Customer:User<br> **Actors:** Mobile Network Operators (MNO), Onboarding/Vetting authority, application developers, enterprise. <br> **Scope:**  |
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The Customer:User has provided mandatory information of their identity</li><li>Application developer has onboarded to MNO API</li><li>Application developer has API credentials</li></ol>|
| ***Activities/Steps*** | **Starts when:** The enterprise wants its branded company name be displayed when calling a phone number to avoid any spoofing .<br>**Ends when:** The MNO service returns an acknowledgment or an error.<br> |
| ***Post-conditions*** | The application developer can make decision to use this customer data to follow-up enterprise processes|
| ***Exceptions*** | Several exceptions might occur during the Verified Caller API operations:<br><ul><li>Unauthorized: Not valid credentials (e.g. use of already expired access token).</li><li>Not Found: The called or caller phone number provided is not managed by the MNO</li><li>Invalid input: Not all mandatory  input data to invoke operation (e.g. phone number).</li></ul>|
