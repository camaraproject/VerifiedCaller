# Changelog VerifiedCaller

<!-- TOC:START -->
## Table of Contents
- **[r2.4](#r24)**
- [r2.3](#r23)
- [r2.2](#r22)
- [r2.1](#r21)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r2.4

## Release Notes

This public release contains the definition and documentation of
* brand-registration 0.2.0
* verified-caller 0.2.0

The API definition(s) are based on
* Commonalities r4.4 (0.9.0)
* Identity and Consent Management r4.2 (0.5.0)

## brand-registration 0.2.0

**brand-registration 0.2.0 is an initial public version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.4/code/API_definitions/brand-registration.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.4/code/API_definitions/brand-registration.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.4/code/API_definitions/brand-registration.yaml)

### Breaking changes

* `409` returns code `ALREADY_EXISTS` instead of `CONFLICT`, aligned with Commonalities r4.4, by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/153
* `404` of `POST /registrations` returns code `IDENTIFIER_NOT_FOUND` instead of `NOT_FOUND` or `GENERIC_404_IDENTIFIER_NOT_FOUND` by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/176

### Added

* New operation `GET /registrations` to list the registrations of the API consumer, with optional filter query parameters and pagination, by @alpaycetin74, @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/78, https://github.com/camaraproject/VerifiedCaller/pull/94, https://github.com/camaraproject/VerifiedCaller/pull/113, https://github.com/camaraproject/VerifiedCaller/pull/174
* Support for visual assets (e.g. logo, image, video) to display in the callee's device. by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/81
* Add Status to Registration Response by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/83
* Optional event notifications: `sink` and `sinkCredential` in `POST` and `PUT`, events `call-branded`, `status-changed`, `quota-threshold-reached` and `quota-exhausted`; `422 EVENT_NOTIFICATIONS_NOT_SUPPORTED` if the provider does not support notifications, `400` codes for an invalid `sink` or `sinkCredential`, by @mohdfarhanakram, @GillesInnov35, @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/86, https://github.com/camaraproject/VerifiedCaller/pull/93, https://github.com/camaraproject/VerifiedCaller/pull/175
* Update brand-registration.yaml: new property "expiresAt", new status enum "expired", new filter "expiresAt" in GET operation; a past "expiresAt" is rejected with `400 OUT_OF_RANGE`, by @GillesInnov35, @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/103, https://github.com/camaraproject/VerifiedCaller/pull/175
* Enhance brand registration API with quota fields by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/114
* Add callPurpose field to brand registration by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/115
* Add createdAt and updatedAt fields to brand registration by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/129
* Test definitions for `GET /registrations`, and further success and error scenarios for all operations, by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/140, https://github.com/camaraproject/VerifiedCaller/pull/151, https://github.com/camaraproject/VerifiedCaller/pull/173, https://github.com/camaraproject/VerifiedCaller/pull/175, https://github.com/camaraproject/VerifiedCaller/pull/176

### Changed

* `terminatingCountryCode` is an `int32` in the range 1-999 by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/117
* `customerId` has a maximum length of 64 characters by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/99
* Request bodies with properties not declared in the API definition are rejected with `400 INVALID_ARGUMENT`, aligned with Commonalities r4.4, by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/119
* Descriptions clarified: behaviour of `verifyCallerAction`; `PUT` replaces the full registration and may reject changes to parameters the provider treats as immutable; the provider may reject `displayName`, `customerId` or `campaignName` after further validation, by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/143, https://github.com/camaraproject/VerifiedCaller/pull/151, https://github.com/camaraproject/VerifiedCaller/pull/175

### Fixed

* N/A

### Removed

* `404` code `NOT_FOUND` from the operations on `/registrations/{registrationId}`, and `GENERIC_404_IDENTIFIER_NOT_FOUND` from `PUT`, by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/176
* `429` code `QUOTA_EXCEEDED` by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/119
* `500` and `503` responses are no longer documented (CAMARA API Design Guide r4.4, section 3.2.1) by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/176

## verified-caller 0.2.0

**verified-caller 0.2.0 is an initial public version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.4/code/API_definitions/verified-caller.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.4/code/API_definitions/verified-caller.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.4/code/API_definitions/verified-caller.yaml)

### Breaking changes

* `409` returns code `ALREADY_EXISTS` instead of `CONFLICT`, aligned with Commonalities r4.4, by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/153
* `404` returns code `IDENTIFIER_NOT_FOUND` instead of `NOT_FOUND` or `GENERIC_404_IDENTIFIER_NOT_FOUND` by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/176

### Added

* Introduce callReason parameter by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/104
* Test definitions with success scenarios and further error scenarios by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/142, https://github.com/camaraproject/VerifiedCaller/pull/151

### Changed

* Request bodies with properties not declared in the API definition are rejected with `400 INVALID_ARGUMENT`, aligned with Commonalities r4.4, by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/125
* Strategy `SMS` is reserved for future use by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/143
* Descriptions clarified: roles, pre-announcement, `timeToLive` handling, one verified call per pre-announcement; the provider may reject `dynamicDisplayName` after further validation, by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/143, https://github.com/camaraproject/VerifiedCaller/pull/151

### Fixed

* N/A

### Removed

* `429` code `QUOTA_EXCEEDED` by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/125
* `500` and `503` responses are no longer documented (CAMARA API Design Guide r4.4, section 3.2.1) by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/176

**Full Changelog**: https://github.com/camaraproject/VerifiedCaller/compare/r1.3...r2.4

# r2.3

## Release Notes

This release candidate contains the definition and documentation of
* brand-registration 0.2.0-rc.2
* verified-caller 0.2.0-rc.2

The API definition(s) are based on
* Commonalities r4.4 (0.9.0)
* Identity and Consent Management r4.2 (0.5.0)

## brand-registration 0.2.0-rc.2

**brand-registration 0.2.0-rc.2 is a release-candidate version of this API.**

Changes documented below are compared to version 0.2.0-rc.1.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.3/code/API_definitions/brand-registration.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.3/code/API_definitions/brand-registration.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.3/code/API_definitions/brand-registration.yaml)

### Breaking changes

* N/A

### Added

* Create a resource for an API consumer to retrieve their registration information by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/78
* Support for visual assets (e.g. logo, image, video) to display in the callee's device. by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/81
* Add Status to Registration Response by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/83
* Add call-branded event notifications to brand-registration API by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/86
* Enhance brand-registration.yaml with new event schemas by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/93
* Add optional filter query parameters to GET /registrations (#87) by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/94
* Add maxLength constraint to CustomerId schema (#97) by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/99
* Update brand-registration.yaml: new property "expiredAt", new status enum "expired", new filter "expiredAt" in GET operation by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/103
* Enhance brand registration API with quota fields by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/114
* Add callPurpose field to brand registration by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/115
* Add createdAt and updatedAt fields to brand registration by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/129

### Changed

* N/A

### Fixed

* Align GET /registrations pagination with Commonalities by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/113
* Align responses with commonalities r4.4 by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/153
* Improve test documentation by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/151

### Removed

* N/A

## verified-caller 0.2.0-rc.2

**verified-caller 0.2.0-rc.2 is a release-candidate version of this API.**

Changes documented below are compared to version 0.2.0-rc.1.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.3/code/API_definitions/verified-caller.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.3/code/API_definitions/verified-caller.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.3/code/API_definitions/verified-caller.yaml)

### Breaking changes

* N/A

### Added

* Introduce callReason parameter by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/104

### Changed

* N/A

### Fixed

* Resolve linter hints in api specs by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/130
* Align responses with commonalities r4.4 by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/153
* Improve test documentation by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/151

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/VerifiedCaller/compare/r2.2...r2.3

# r2.2

## Release Notes

This release candidate contains the definition and documentation of
* brand-registration 0.2.0-rc.1
* verified-caller 0.2.0-rc.1

The API definition(s) are based on
* Commonalities r4.3 (0.8.0)
* Identity and Consent Management r4.2 (0.5.0)

## brand-registration 0.2.0-rc.1

**brand-registration 0.2.0-rc.1 is a release-candidate version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.2/code/API_definitions/brand-registration.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.2/code/API_definitions/brand-registration.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.2/code/API_definitions/brand-registration.yaml)

### Breaking changes

* N/A

### Added

* Create a resource for an API consumer to retrieve their registration information by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/78
* Support for visual assets (e.g. logo, image, video) to display in the callee's device. by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/81
* Add Status to Registration Response by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/83
* Add call-branded event notifications to brand-registration API by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/86
* Enhance brand-registration.yaml with new event schemas by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/93
* Add optional filter query parameters to GET /registrations (#87) by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/94
* Add maxLength constraint to CustomerId schema (#97) by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/99
* Update brand-registration.yaml: new property "expiredAt", new status enum "expired", new filter "expiredAt" in GET operation by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/103
* Enhance brand registration API with quota fields by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/114
* Add callPurpose field to brand registration by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/115
* Add createdAt and updatedAt fields to brand registration by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/129
* Improve descriptions in API specification by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/143

### Changed

* N/A

### Fixed

* Align GET /registrations pagination with Commonalities by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/113

### Removed

* N/A

## verified-caller 0.2.0-rc.1

**verified-caller 0.2.0-rc.1 is a release-candidate version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.2/code/API_definitions/verified-caller.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.2/code/API_definitions/verified-caller.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.2/code/API_definitions/verified-caller.yaml)

### Breaking changes

* N/A

### Added
* Introduce callReason parameter by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/104
* Improve test documentation by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/142
* Improve descriptions in API specification by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/143

### Changed

* N/A

### Fixed

* N/A

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/VerifiedCaller/compare/r1.3...r2.2

# r2.1

## Release Notes

This pre-release contains the definition and documentation of
* brand-registration 0.2.0-alpha.1
* verified-caller 0.2.0-alpha.1

The API definition(s) are based on
* Commonalities 0.8.0
* Identity and Consent Management 0.5.0

## brand-registration 0.2.0-alpha.1

**brand-registration 0.2.0-alpha.1 is an alpha version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.1/code/API_definitions/brand-registration.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.1/code/API_definitions/brand-registration.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.1/code/API_definitions/brand-registration.yaml)

### Breaking changes

* N/A

### Added

* Create a resource for an API consumer to retrieve their registration information by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/78
* Support for visual assets (e.g. logo, image, video) to display in the callee's device. by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/81
* Add Status to Registration Response by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/83
* Add call-branded event notifications to brand-registration API by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/86
* Enhance brand-registration.yaml with new event schemas by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/93
* Add optional filter query parameters to GET /registrations (#87) by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/94
* Update brand-registration.yaml by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/103
* Align GET /registrations pagination with Commonalities by @mohdfarhanakram in https://github.com/camaraproject/VerifiedCaller/pull/113
* Enhance brand registration API with quota fields by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/114
* Add callPurpose field to brand registration by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/115
* Commonalities 8.0.0 alignment   common artifacts by @GillesInnov35 in https://github.com/camaraproject/VerifiedCaller/pull/119

### Changed

* N/A

### Fixed

* Fix linter warnings before release by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/117

### Removed

* N/A

## verified-caller 0.2.0-alpha.1

**verified-caller 0.2.0-alpha.1 is an alpha version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.1/code/API_definitions/verified-caller.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r2.1/code/API_definitions/verified-caller.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r2.1/code/API_definitions/verified-caller.yaml)

### Breaking changes

* N/A

### Added

* Introduce callReason parameter by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/104

### Changed

* N/A

### Fixed

* N/A

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/VerifiedCaller/compare/r1.3...r2.1

