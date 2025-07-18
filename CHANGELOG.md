# Verified Caller Changelog
> **Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published.
For the best results, use the latest published release.**

## Table of Contents
- **[r1.1](#r11)**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r1.1
## Release Notes

This **pre-release** contains the definition and documentation of
* Brand Registration v0.1.0-rc.1
* Verified Caller Pre-Announcement v0.1.0-rc.1

The API definition(s) are based on
* Commonalities r3.2
* Identity and Consent Management r3.2

## Brand Registration v0.1.0-rc.1
This is the first release candidate for the first unstable version of Brand Registration API

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r1.1/code/API_definitions/brand-registration.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r1.1/code/API_definitions/brand-registration.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r1.1/code/API_definitions/brand-registration.yaml)

### Added
* Add new endpoint to create, edit, query and delete a brand registration for call enrichment by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/47

### Changed
* N/A

### Fixed
* N/A

### Removed
* N/A

**Full Changelog**: https://github.com/camaraproject/VerifiedCaller/commits/main/code/API_definitions/brand-registration.yaml


## Verified Caller Pre-Announcement v0.1.0-rc.1
This is the first release candidate for the first unstable version of Verified Caller Preannouncement API

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r1.1/code/API_definitions/verifiedcaller-preannounce.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/VerifiedCaller/r1.1/code/API_definitions/verifiedcaller-preannounce.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/VerifiedCaller/blob/r1.1/code/API_definitions/verifiedcaller-preannounce.yaml)

### Added
* Add new endpoint to pre-announce a call to be branded by @alpaycetin74 in https://github.com/camaraproject/VerifiedCaller/pull/43

### Changed
* N/A

### Fixed
* N/A

### Removed
* N/A

**Full Changelog**: https://github.com/camaraproject/VerifiedCaller/commits/main/code/API_definitions/verifiedcaller-preannounce.yaml
