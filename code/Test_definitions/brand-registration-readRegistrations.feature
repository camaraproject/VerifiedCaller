Feature: CAMARA Brand Registration API, vwip - Operation: readRegistrations

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in /code/API_definitions/brand-registration.yml
# Implementation indications:
# * apiRoot: API root of the server URL
#
# Testing assets:
# * Pre-existing brand registrations "registrationId_1" through "registrationId_7" that can be successfully associated with the brand's owner by the service provider

  Background: Brand Registration setup
    Given an environment at "apiRoot"
    And the resource "/brand-registration/vwip/registrations"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"

  # Success scenarios

  @BrandRegistration__GET_200.01_success_scenario_all_registrations_read
  Scenario: Read existing registrations of a brand owner where no filter is defined and response is not paginated
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And header parameter "page" is set to 1
    And header parameter "perpage" is set to perpage1 where perpage1 >= 7
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 7 elements that reflect data of registrationId_1 through registrationId_7 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 1 and "$.pagination.perPage" = perpage1 and "$.pagination.totalCount" = 7 and "$.pagination.totalPages" = 1

  @BrandRegistration__GET_200.02_success_scenario_some_registrations_read_with_filter
  Scenario: Read existing registrations of a brand owner where a filter is defined and response is not paginated
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And only registrations "registrationId_1" through "registrationId_3" have "$.terminatingCountryCode" property set to terminatingCountryCode1
    And Request URI parameter terminatingCountryCode is present and set to value terminatingCountryCode1
    And header parameter "page" is set to 1
    And header parameter "perpage" is set to perpage1 where perpage1 >= 7
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 3 elements that reflect data of registrationId_1 and registrationId_3 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 1 and "$.pagination.perPage" = perpage1 and "$.pagination.totalCount" = 3 and "$.pagination.totalPages" = 1

  @BrandRegistration__GET_200.03_success_scenario_some_registrations_read_with_multiple_filters_combined
  Scenario: Read existing registrations of a brand owner where multiple filters are defined and response is not paginated
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And only registrations "registrationId_1" through "registrationId_3" have "$.terminatingCountryCode" property set to terminatingCountryCode1
    And only registrations "registrationId_2" through "registrationId_4" have "$.callPurpose" property set to callPurpose1
    And Request URI parameter terminatingCountryCode is present and set to value terminatingCountryCode1
    And Request URI parameter callPurpose is present and set to value callPurpose1
    And header parameter "page" is set to 1
    And header parameter "perpage" is set to perpage1 where perpage1 >= 7
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 2 elements that reflect data of registrationId_2 and registrationId_3 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 1 and "$.pagination.perPage" = perpage1 and "$.pagination.totalCount" = 2 and "$.pagination.totalPages" = 1

  @BrandRegistration__GET_200.04_success_scenario_no_registrations_found
  Scenario: Read existing registrations of a brand owner where no filter is defined and no results are found
    Given the brand's owner cannot be associated with any registration data in the service provider
    And header parameter "page" is set to page1
    And header parameter "perpage" is set to perPage1
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains no elements
    And the response property "$.pagination" is present where "$.pagination.page" = page1 and "$.pagination.perPage" = perPage1 and "$.pagination.totalCount" = 0 and "$.pagination.totalPages" = 0

  @BrandRegistration__GET_200.05_success_scenario_no_registrations_found_page_out_of_bounds
  Scenario: Read existing registrations of a brand owner where no filter is defined and no results are found as requested page is out of bounds
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And header parameter "page" is set to 5
    And header parameter "perpage" is set to 2
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains no elements
    And the response property "$.pagination" is present where "$.pagination.page" = 5 and "$.pagination.perPage" = 2 and "$.pagination.totalCount" = 0 and "$.pagination.totalPages" = 0

  @BrandRegistration__GET_200.06_success_scenario_no_registrations_found_with_filter
  Scenario: Read existing registrations of a brand owner where a filter is defined and no matching results found
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And none of the registrations "registrationId_1" through "registrationId_7" have "$.callPurpose" property set to callPurpose1
    And Request URI parameter callPurpose is present and set to value callPurpose1
    And header parameter "page" is set to page1
    And header parameter "perpage" is set to perPage1
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains no elements
    And the response property "$.pagination" is present where "$.pagination.page" = page1 and "$.pagination.perPage" = perPage1 and "$.pagination.totalCount" = 0 and "$.pagination.totalPages" = 0

  @BrandRegistration__GET_200.07_success_scenario_no_registrations_found_with_combined_filter
  Scenario: Read existing registrations of a brand owner where multiple filters are defined and no matching results found
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And only registrations "registrationId_4" through "registrationId_5" have "$.terminatingCountryCode" property set to terminatingCountryCode2
    And only registrations "registrationId_6" through "registrationId_7" have "$.callPurpose" property set to callPurpose2
    And Request URI parameter terminatingCountryCode is present and set to value terminatingCountryCode2
    And Request URI parameter callPurpose is present and set to value callPurpose2
    And header parameter "page" is set to page1
    And header parameter "perpage" is set to perPage1
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 200
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response headwith "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains no elements
    And the response property "$.pagination" is present where "$.pagination.page" = page1 and "$.pagination.perPage" = perPage1 and "$.pagination.totalCount" = 0 and "$.pagination.totalPages" = 0

  @BrandRegistration__GET_206.01_success_scenario_first_page_of_results_read
  Scenario: Read existing registrations of a brand owner where no filter is defined and response is paginated and first page is returned
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And header parameter "page" is set to 1
    And header parameter "perpage" is set to 2
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 206
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 2 elements that reflect data of registrationId_1 and registrationId_2 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 1 and "$.pagination.perPage" = 2 and "$.pagination.totalCount" = 7 and "$.pagination.totalPages" = 4
    And response header "X-Total-Count" has the same value as the response property "$.pagination.totalCount"
    And response header "X-Total-Pages" has the same value as the response property "$.pagination.totalPages"

  @BrandRegistration__GET_206.02_success_scenario_arbitrary_page_of_results_read
  Scenario: Read existing registrations of a brand owner where no filter is defined and response is paginated and an arbitrary page is returned
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And header parameter "page" is set to 2
    And header parameter "perpage" is set to 2
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 206
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 2 elements that reflect data of registrationId_3 and registrationId_4 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 2 and "$.pagination.perPage" = 2 and "$.pagination.totalCount" = 7 and "$.pagination.totalPages" = 4
    And response header "X-Total-Count" has the same value as the response property "$.pagination.totalCount"
    And response header "X-Total-Pages" has the same value as the response property "$.pagination.totalPages"

  @BrandRegistration__GET_206.03_success_scenario_last_page_of_results_read
  Scenario: Read existing registrations of a brand owner where no filter is defined and response is paginated and last page is returned
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And header parameter "page" is set to 4
    And header parameter "perpage" is set to 2
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 206
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 1 element that reflects data of registrationId_7 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 4 and "$.pagination.perPage" = 2 and "$.pagination.totalCount" = 7 and "$.pagination.totalPages" = 4
    And response header "X-Total-Count" has the same value as the response property "$.pagination.totalCount"
    And response header "X-Total-Pages" has the same value as the response property "$.pagination.totalPages"

  @BrandRegistration__GET_206.04_success_scenario_first_page_of_results_read_with_matching_filter
  Scenario: Read existing registrations of a brand owner where a filter is defined and response is paginated and first page is returned
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And registrations "registrationId_1" through "registrationId_7" have the "$.customerId" property set to customerId1
    And Request URI parameter customerId is present and set to value customerId1
    And header parameter "page" is set to 1
    And header parameter "perpage" is set to 2
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 206
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 2 elements that reflect data of registrationId_1 and registrationId_2 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 1 and "$.pagination.perPage" = 2 and "$.pagination.totalCount" = 7 and "$.pagination.totalPages" = 4
    And response header "X-Total-Count" has the same value as the response property "$.pagination.totalCount"
    And response header "X-Total-Pages" has the same value as the response property "$.pagination.totalPages"

  @BrandRegistration__GET_206.05_success_scenario_arbitrary_page_of_results_read_with_matching_filter
  Scenario: Read existing registrations of a brand owner where a filter is defined and response is paginated and an arbitrary page is returned
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And registrations "registrationId_1" through "registrationId_7" have the "$.customerId" property set to customerId1
    And Request URI parameter customerId is present and set to value customerId1
    And header parameter "page" is set to 2
    And header parameter "perpage" is set to 2
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 206
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 2 elements that reflect data of registrationId_3 and registrationId_4 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 2 and "$.pagination.perPage" = 2 and "$.pagination.totalCount" = 7 and "$.pagination.totalPages" = 4
    And response header "X-Total-Count" has the same value as the response property "$.pagination.totalCount"
    And response header "X-Total-Pages" has the same value as the response property "$.pagination.totalPages"

  @BrandRegistration__GET_206.06_success_scenario_last_page_of_results_read_with_matching_filter
  Scenario: Read existing registrations of a brand owner where a filter is defined and response is paginated and last page is returned
    Given the brand's owner can be associated with registrations "registrationId_1" through "registrationId_7" in the service provider
    And registrations "registrationId_1" through "registrationId_7" have the "$.customerId" property set to customerId1
    And Request URI parameter customerId is present and set to value customerId1
    And header parameter "page" is set to 4
    And header parameter "perpage" is set to 2
    And one of the scopes associated with the access token is brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 206
    And the response body complies with the schema at "/components/schemas/RegistrationRecords"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.registrations" is present and contains 1 element that reflects data of registrationId_7 as previously set by the API consumer
    And the response property "$.pagination" is present where "$.pagination.page" = 4 and "$.pagination.perPage" = 2 and "$.pagination.totalCount" = 7 and "$.pagination.totalPages" = 4
    And response header "X-Total-Count" has the same value as the response property "$.pagination.totalCount"
    And response header "X-Total-Pages" has the same value as the response property "$.pagination.totalPages"

  # Generic 400 errors

  @BrandRegistration__GET_400.1_schema_not_compliant
  Scenario: Invalid Argument. Generic Syntax Exception
    Given the request URI does not contain a registrationId parameter with a valid UUID format
    When the HTTPS "GET" request is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @BrandRegistration__GET_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    When the HTTPS "GET" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration__GET_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    When the HTTPS "GET" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @BrandRegistration__GET_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the HTTPS "GET" request is sent
    Then the response status code is 401
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @BrandRegistration__GET_403.1_missing_access_token_scope
  Scenario: Invalid access token scope
    Given the header "Authorization" is set to an access token that does not include scope brand-registration:read
    When the HTTPS "GET" request is sent
    Then the response status code is 403
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text
