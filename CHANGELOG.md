# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) 
and this project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased

### Fixed

## [0.3.5] - 2019-05-21

### Fixed
* Parsing URLs with uppercase characters

## [0.3.4] - 2018-11-27

### Fixed
* Parsing Lua 5.1 compatibility

## [0.3.3] - 2018-07-31

### Fixed
* Parsing URLs with underscores in domain

## [0.3.2] - 2018-07-20

### Fixed
* Parsing URLs with numbers in host

## [0.3.1] - 2018-07-19

### Fixed
* Parsing URLs with numbers in host

## [0.3.0] - 2018-07-19

### Added
* Support for data-uri

## Changed
* Significantly improve performance

## [0.2.0] - 2017-07-12

### Added
* `resty_url.normalize(url)` to normalize multiple slashes
* `resty_url.join(...)` to join parsed urls and perform normalization

## [0.1.0] - 2017-07-04

Initial release.

[0.1.0]: https://github.com/3scale/lua-resty-url/commit/v0.1.0
[0.2.0]: https://github.com/3scale/lua-resty-url/commit/v0.2.0
