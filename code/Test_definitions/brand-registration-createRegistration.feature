Feature: Camara Brand Registration API, vwip - Operation: POST /registrations

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in /code/API_definitions/brand-registration.yml
# Implementation indications:
# * apiRoot: API root of the server URL
#
# Testing assets:
# * An optional customer identifier "customerId1" to indicate the owner of the registration, typically for logically grouping & billing the registration operations.
# * An E.164 telephony number "phoneNumber1" that is owned by the customer "customerId1"
# * An optional E.164 telephony number "phoneNumberAlternate1" that is owned by the customer "customerId1"
# * A display name "displayName1" that is to be displayed to the callee in case of calls made by phoneNumber1 and optionally phoneNumberAlternate1
# * An E.164 country code "terminatingCountryCode1" that identifies the target country of potenital callees where the display name is to be shown.
# * An optional verify caller instruction "verifyCallerAction1" that can be included in the registration to determine the action if the calling party's authenticity cannot be established via the capabilities of the Verified Caller APIs.

  Background: Brand Registration setup
    Given an environment at "apiRoot"
    And the resource "/brand-registration/vwip/registrations"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is compliant with the RequestBody schema defined by "/components/schemas/CreateOrUpdateRegistrationRequest"

  # Success scenarios

  @BrandRegistration__POST_201.01_success_scenario_1_all_parameters_provided
  Scenario: Create a brand registration for customer1
    Given the API consumer can be verified as customer1
    And request property "$.phoneNumber" is set to phoneNumber1
    And request property "$.phoneNumberAlternate" is present and set to phoneNumberAlternate1
    And request property "$.displayName" is set to displayName1
    And request property "$.terminatingCountryCode" is set to terminatingCountryCode1
    And request property "$.customerId" is present and set to customerId1
    And request property "$.verifyCallerAction" is present and set to verifyCallerAction1
    And one of the scopes associated with the access token is brand-registration:create
    When the HTTPS "POST" request is sent
    Then the response status code is 201
    And the response body complies with the schema at "/components/schemas/RegistrationRecord"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And response properties mirror request properties
    And response property "$.registrationId" is set to a UUID created by the service provider.

  # Generic 400 errors

  @BrandRegistration__POST_400.1_schema_not_compliant
  Scenario: Invalid Argument. Generic Syntax Exception
    Given the request body is set to any value which is not compliant with the schema at "/components/schemas/CreateOrUpdateRegistrationRequest"
    When the HTTPS "POST" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration__POST_400.2_no_request_body
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

  @BrandRegistration__POST_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the HTTPS "POST" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration__POST_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the HTTPS "POST" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration__POST_401.3_invalid_access_token
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

  @BrandRegistration__POST_403.1_missing_access_token_scope
  Scenario: Invalid access token scope
    Given the header "Authorization" is set to an access token that does not include scope brand-registration:create
    When the HTTPS "POST" request is sent
    Then the response status code is 403
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text