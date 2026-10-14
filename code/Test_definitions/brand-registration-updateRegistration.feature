Feature: CAMARA Brand Registration API, vwip - Operation: PUT updateRegistration

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in /code/API_definitions/brand-registration.yml
# Implementation indications:
# * apiRoot: API root of the server URL
#
# Testing assets:
# * A pre-existing brand registration "registrationId1"
# * An optional customer identifier "customerId1" to indicate the owner of the registration, typically for logically grouping & billing the registration operations.
# * A telephony number "phoneNumber1" that is owned by the customer "customerId1"
# * An optional telephony number "phoneNumberAlternate1" that is owned by the customer "customerId1"
# * A display name "displayName1" that is a string to be displayed to the callee in case of calls made by phoneNumber1 and optionally phoneNumberAlternate1
# * A country code "terminatingCountryCode1" per ITU-T E.164 Recommendation that identifies the target country of potential callees where the display name is to be shown.
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
    And the request URI includes a registrationId parameter that is in a valid UUID format

  # Success scenarios

  @BrandRegistration_PUT_200.01_success_scenario_all_parameters_provided
  Scenario: Replace an existing brand registration data indicated by registrationId1
    Given the API consumer can be verified against a registration "registrationId1" in the service provider
    And URI parameter "registrationId" is set to registrationId1
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
    And one of the scopes associated with the access token is brand-registration:update
    When the HTTPS "PUT" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecord"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And response property "$.registrationId" is equal to the registrationId1 in the request URI
    And response property "$.sinkCredential" is excluded from the response
    And the other request properties are mirrored in the response properties
    And response property "$.createdAt" is set to the time the record is created
    And response property "$.updatedAt" is set to the time the record is modified (time of this PUT operation)
    And response property "$.status" is set to status of the registration in the service provider
    And response property "$.quota" is set to quota1
    And response property "$.quotaThreshold" is set to quotaThreshold1

  # Generic 400 errors

  @BrandRegistration_PUT_400.1_schema_not_compliant
  Scenario: Invalid Argument. Generic Syntax Exception
    Given the request body is set to any value which is not compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    When the HTTPS "PUT" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_400.2_expiresAt_not_in_the_future
  Scenario: The expiresAt value specified in the API request is not in the future
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.expiresAt" is present and syntactically valid but not set to a value in the future
    When the HTTPS "PUT" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_400.3_improper_use_of_displayName
  Scenario: The service provider applies further validations to the displayName value specified in the API request, and the value includes profanity
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.displayName" is syntactically valid but contains profanity
    When the HTTPS "PUT" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_400.4_improper_use_of_displayAsset
  Scenario: The service provider applies further validations to the displayAsset object specified in the API request, and the object demonstrates indecency
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.displayAsset" is present and is syntactically valid but the visual asset demonstrates indecency
    When the HTTPS "PUT" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_400.5_customerId_invalid
  Scenario: The service provider applies further validations to the customerId value specified in the API request, and the value is not acceptable, e.g. not recognized in the system.
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.customerId" is present and syntactically valid but set to a value not recognized in the service provider's system
    When the HTTPS "PUT" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_400.6_campaignName_invalid
  Scenario: The service provider applies further validations to the campaignName value specified in the API request, and the value is not acceptable, e.g. not recognized in the system.
    Given the request body is set to any value which is compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    And request property "$.campaignName" is present and syntactically valid but set to a value not recognized in the service provider's system
    When the HTTPS "PUT" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_400.7_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the HTTPS "PUT" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @BrandRegistration_PUT_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the HTTPS "PUT" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the HTTPS "PUT" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration_PUT_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the HTTPS "PUT" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @BrandRegistration_PUT_403.1_missing_access_token_scope
  Scenario: Invalid access token scope
    Given the header "Authorization" is set to an access token that does not include scope brand-registration:update
    When the HTTPS "PUT" request is sent
    Then the response status code is 403
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text
