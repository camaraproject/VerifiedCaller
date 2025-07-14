Feature: Camara Brand Registration API, v0.1.0-rc.1 - Operation: DEL

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in /code/API_definitions/brand-registration.yml
# Implementation indications:
# * api_root: API root of the server URL
#
# Testing assets:
# * A pre-existing brand registration "registrationId1" that can be successfully associated with the API consumer by the service provider
# * An optional customer identifier "customerId1" to indicate the owner of the registration, typically for logically grouping & billing the registration operations.
# * An E.164 telephony number "phoneNumber1" that is owned by the customer "customerId1"
# * An optional E.164 telephony number "phoneNumberAlternate1" that is owned by the customer "customerId1"
# * A display name "displayName1" that is to be displayed to the callee in case of calls made by phoneNumber1 and optionally phoneNumberAlternate1
# * An E.164 country code "terminatingCountryCode1" that identifies the target country of potenital callees where the display name is to be shown.
# * An optional verify caller instruction "verifyCallerAction1" that can be included in the registration to determine the action if the calling party's authenticity cannot be established via the capabilities of the Verified Caller APIs.

  Background: Brand Registration setup
    Given an environment at "apiRoot"
    And the resource "/brand-registration/v0.1rc1/registrations"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request URI includes a registrationId parameter that is is a valid UUID format

  # Success scenarios

  @BrandRegistration__DEL_204.01_success_scenario_1
  Scenario: Delete an existing brand registration
    Given the API consumer can be associated with a registration "registrationId1" in the service provider
    And URI parameter "registrationId" is set to registrationId1
    And one of the scopes associated with the access token is brand-registration:delete
    When the HTTPS "DEL" request is sent
    Then the response status code is 204
    And the response is empty
    And the response header "x-correlator" has same value as the request header "x-correlator"

  # Generic 400 errors

  @BrandRegistration__DEL_400.1_schema_not_compliant
  Scenario: Invalid Argument. Generic Syntax Exception
    Given the request URI does not contain a registrationId parameter with a valid UUID format
    When the HTTPS "DEL" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @BrandRegistration__DEL_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the HTTPS "DEL" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration__DEL_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the HTTPS "DEL" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration__DEL_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the HTTPS "DEL" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @BrandRegistration__DEL_403.1_missing_access_token_scope
  Scenario: Invalid access token scope
    Given the header "Authorization" is set to an access token that does not include scope brand-registration:delete
    When the HTTPS "DEL" request is sent
    Then the response status code is 403
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text