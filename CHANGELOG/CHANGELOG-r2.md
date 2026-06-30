# Changelog VerifiedCaller

<!-- TOC:START -->
## Table of Contents
- [r2.1](#r21)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

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

