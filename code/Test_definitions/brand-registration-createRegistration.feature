Feature: CAMARA Brand Registration API, vwip - Operation: createRegistration

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in /code/API_definitions/brand-registration.yml
# Implementation indications:
# * apiRoot: API root of the server URL
#
# Testing assets:
# * An optional customer identifier "customerId1" to indicate the owner of the registration, typically for logically grouping & billing the registration operations.
# * A telephony number "phoneNumber1" that is owned by the customer "customerId1"
# * An optional telephony number "phoneNumberAlternate1" that is owned by the customer "customerId1"
# * A display name "displayName1" that is a string to be displayed to the callee in case of calls made by phoneNumber1 and optionally phoneNumberAlternate1
# * An country code "terminatingCountryCode1" per ITU-T E.164 Recommendation that identifies the target country of potential callees where the display name is to be shown.
# * An optional verify caller instruction "verifyCallerAction1" that can be included in the registration to determine the action if the calling party's authenticity cannot be established via the capabilities of the Verified Caller APIs.
# * An optional expiresAt "expiresAt1" that indicates when the registration shall expire.
# * An optional displayAsset "displayAsset1" that is the URL of a visual to be displayed to the callee in case of calls made by phoneNumber1 and optionally phoneNumberAlternate1
# * An optional campaignName "campaignName1" that is typically used for logically grouping & billing the registration operations.
# * An optional callPurpose "callPurpose1" that is typically used for logically grouping & billing the registration operations.
# * An optional sink "sink1" that is an HTTPS endpoint url to send event notifications pertaining to the registration.
# * An optional sinkCredential "sinkCredential1"  that is used to authenticate to the sink endpoint.
# * A quota "quota1" to indicate the maximum value of calls that can be branded based on this registration, previously established in the service provider's system
# * A quotaThreshold "quotaThreshold1" to indicate the number of branded calls when the customer is notified of a possible quota expiry in near future, previously established in the service provider's system

  Background: Brand Registration setup
    Given an environment at "apiRoot"
    And the resource "/brand-registration/vwip/registrations"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is compliant with the RequestBody schema defined by "/components/schemas/CreateOrUpdateRegistrationRequest"

  # Success scenarios

  @BrandRegistration_POST_201.01_success_scenario_all_parameters_provided
  Scenario: Create a brand registration
    Given the API consumer can be verified in the service provider's system
    And request property "$.phoneNumber" is set to phoneNumber1
    And request property "$.phoneNumberAlternate" is present and set to phoneNumberAlternate1
    And request property "$.displayName" is set to displayName1
    And request property "$.terminatingCountryCode" is set to terminatingCountryCode1
    And request property "$.customerId" is present and set to customerId1
    And request property "$.verifyCallerAction" is present and set to verifyCallerAction1
    And request property "$.expiresAt" is present and set to expiresAt1
    And request property "$.displayAsset" is present and set to displayAsset1
    And request property "$.campaignName" is present and set to campaignName1
    And request property "$.callPurpose" is present and set to callPurpose1
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    And one of the scopes associated with the access token is brand-registration:create
    When the HTTPS "POST" request is sent
    Then the response status code is 201
    And the response body complies with the schema at "/components/schemas/RegistrationRecord"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And request properties are mirrored in the response properties except "$.sinkCredential", which is excluded from the response
    And response property "$.registrationId" is set to a registrationId1 created by the service provider
    And response property "$.createdAt" is set to the time the record is created
    And response property "$.status" is set to status of the registration in the service provider
    And response property "$.quota" is set to quota1
    And response property "$.quotaThreshold" is set to quotaThreshold1

  @BrandRegistration_POST_callback_01_async_registration_initial_event_validation
  Scenario: Receive notification for initial status-changed event on creation
    Given a valid subscription request body
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    When the HTTPS "POST" request is sent
    Then the response code is 201
    And response property "$.registrationId" is set to registrationId1 created by the service provider
    And service provider's system processes the registration request asynchronously
    And an event notification is received on sink1
    And event notification body complies with the OAS schema at "#/components/schemas/EventStatusChanged"
    And event notification body property "$.type" is "org.camaraproject.brand-registration.v0.status-changed"
    And event notification body property "$.data.registrationId" is equal to registrationId1
    And event notification body property "$.data.status" is "pending"

  @BrandRegistration_POST_callback_02_async_registration_activation_event_validation
  Scenario: Receive notification for activation of a brand registration
    Given a valid subscription request body
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    When the HTTPS "POST" request is sent
    Then the response code is 201
    And response property "$.registrationId" is set to registrationId1 created by the service provider
    And service provider's system processes the registration request asynchronously
    And service provider's system completes the activation of the registration
    And an event notification is received on sink1
    And event notification body complies with the OAS schema at "#/components/schemas/EventStatusChanged"
    And event notification body property "$.type" is "org.camaraproject.brand-registration.v0.status-changed"
    And event notification body property "$.data.registrationId" is equal to registrationId1
    And event notification body property "$.data.status" is "active"

  @BrandRegistration_POST_callback_03_subscription_expiry_event_validation
  Scenario: Receive notification for expiry of a brand registration
    Given a valid subscription request body
    And request property "$.expiresAt" is present and set to expiresAt1
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    When the HTTPS "POST" request is sent
    Then the response code is 201
    And response property "$.registrationId" is set to registrationId1 created by the service provider
    And enough time has ellapsed to reach timestamp expiresAt1
    And an event notification is received on sink1
    And event notification body complies with the OAS schema at "#/components/schemas/EventStatusChanged"
    And event notification body property "$.type" is "org.camaraproject.brand-registration.v0.status-changed"
    And event notification body property "$.data.registrationId" is equal to registrationId1
    And event notification body property "$.data.status" is "expired"

  @BrandRegistration_POST_callback_04_call_branding_event_validation
  Scenario: Receive notification for a call branded in the service provider's network
    Given a valid subscription request body
    And request property "$.phoneNumber" is set to phoneNumber1
    And request property "$.displayName" is set to displayName1
    And request property "$.expiresAt" is present and set to expiresAt1
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    When the HTTPS "POST" request is sent
    Then the response code is 201
    And response property "$.registrationId" is set to registrationId1 created by the service provider
    And the registration reaches active state
    And a call from phoneNumber1 is established and branded in the service provider's network
    And an event notification is received on sink1
    And event notification body complies with the OAS schema at "#/components/schemas/EventCallBranded"
    And event notification body property "$.type" is "org.camaraproject.brand-registration.v0.call-branded"
    And event notification body property "$.data.registrationId" is equal to registrationId1
    And event notification body property "$.data.displayNameUsed" is equal to displayName1
    And event notification body property "$.data.strategy" is equal to "BRAND_DISPLAY"

  @BrandRegistration_POST_callback_05_call_branding_with_preannouncement_event_validation
  Scenario: Receive notification for a pre-announced call branded in the service provider's network
    Given a valid subscription request body
    And request property "$.phoneNumber" is set to phoneNumber1
    And request property "$.displayName" is set to displayName1
    And request property "$.verifyCallerAction" is present
    And request property "$.expiresAt" is present and set to expiresAt1
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    When the HTTPS "POST" request is sent
    Then the response code is 201
    And response property "$.registrationId" is set to registrationId1 created by the service provider
    And the registration reaches active state
    And the API consumer successfully creates a pre-announcement "preAnnouncementId1" for a call from phoneNumber1 to phoneNumber2
    And a call from phoneNumber1 to phoneNumber2 is established, verified and branded in the service provider's network
    And an event notification is received on sink1
    And event notification body complies with the OAS schema at "#/components/schemas/EventCallBranded"
    And event notification body property "$.type" is "org.camaraproject.brand-registration.v0.call-branded"
    And event notification body property "$.data.registrationId" is equal to registrationId1
    And event notification body property "$.data.displayNameUsed" is equal to displayName1
    And event notification body property "$.data.strategy" is equal to "BRAND_DISPLAY"
    And event notification body property "$.data.preAnnouncementId" is equal to preAnnouncementId1

  @BrandRegistration_POST_callback_06_quota_threshold_reached_event_validation
  Scenario: Receive notification for branding quota threshold reached in the service provider's network
    Given a valid subscription request body
    And request property "$.phoneNumber" is set to phoneNumber1
    And request property "$.displayName" is set to displayName1
    And request property "$.expiresAt" is present and set to expiresAt1
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    And a quotaThreshold "quotaThreshold1" is previously established in service provider's system
    When the HTTPS "POST" request is sent
    Then the response code is 201
    And response property "$.registrationId" is set to registrationId1 created by the service provider
    And response property "$.quotaThreshold" is set to quotaThreshold1
    And the registration reaches active state
    And quotaThreshold1 calls from phoneNumber1 are established and branded in the service provider's network
    And an event notification is received on sink1
    And event notification body complies with the OAS schema at "#/components/schemas/EventQuotathresholdReached"
    And event notification body property "$.type" is "org.camaraproject.brand-registration.v0.quota-threshold-reached"
    And event notification body property "$.data.registrationId" is equal to registrationId1
    And event notification body property "$.data.quotaThreshold" is equal to quotaThreshold1

  @BrandRegistration_POST_callback_06_quota_exhausted_event_validation
  Scenario: Receive notification for branding quota exhausted in the service provider's network
    Given a valid subscription request body
    And request property "$.phoneNumber" is set to phoneNumber1
    And request property "$.displayName" is set to displayName1
    And request property "$.expiresAt" is present and set to expiresAt1
    And request property "$.sink" is present and set to sink1
    And request property "$.sinkCredential" is present and set to sinkCredential1
    And a quota "quota1" is previously established in service provider's system
    When the HTTPS "POST" request is sent
    Then the response code is 201
    And response property "$.registrationId" is set to registrationId1 created by the service provider
    And response property "$.quota" is set to quota1
    And the registration reaches active state
    And quotaThreshold1 calls from phoneNumber1 are established and branded in the service provider's network
    And an event notification is received on sink1
    And event notification body complies with the OAS schema at "#/components/schemas/EventQuotaExhausted"
    And event notification body property "$.type" is "org.camaraproject.brand-registration.v0.quota-exhausted"
    And event notification body property "$.data.registrationId" is equal to registrationId1
    And event notification body property "$.data.quota" is equal to quota1

  # Generic 400 errors

  @BrandRegistration_POST_400.1_schema_not_compliant
  Scenario: Invalid Argument. Generic Syntax Exception
    Given the request body is set to any value which is not compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_400.2_expiresAt_not_in_the_future
  Scenario: The expiresAt value specified in the API request is not in the future
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.expiresAt" is present and syntactically valid but not set to a value in the future
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_400.3_improper_use_of_displayName
  Scenario: The service provider applies further validations to the displayName value specified in the API request, and the value includes profanity
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.displayName" is syntactically valid but contains profanity
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_400.4_improper_use_of_displayAsset
  Scenario: The service provider applies further validations to the displayAsset object specified in the API request, and the object demonstrates indecency
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.displayAsset" is present and is syntactically valid but the visual asset demonstrates indecency
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_400.5_customerId_invalid
  Scenario: The service provider applies further validations to the customerId value specified in the API request, and the value is not acceptable, e.g. not recognized in the system.
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.customerId" is present and syntactically valid but set to a value not recognized in the service provider's system
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_400.6_campaignName_invalid
  Scenario: The service provider applies further validations to the campaignName value specified in the API request, and the value is not acceptable, e.g. not recognized in the system.
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.campaignName" is present and syntactically valid but set to a value not recognized in the service provider's system
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_400.7_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @BrandRegistration_POST_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the HTTPS "POST" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the HTTPS "POST" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_POST_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the HTTPS "POST" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @BrandRegistration_POST_403.1_missing_access_token_scope
  Scenario: Invalid access token scope
    Given the header "Authorization" is set to an access token that does not include scope brand-registration:create
    When the HTTPS "POST" request is sent
    Then the response status code is 403
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text
