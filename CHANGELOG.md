# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](Https://conventionalcommits.org) for commit guidelines.

<!-- changelog -->

## [v1.1.1](https://github.com/zoonect-oss/ash_uuid/compare/v1.1.0...v1.1.1) (2024-07-01)




### Improvements:

* remove non-simple equality check

## [v1.1.0](https://github.com/zoonect-oss/ash_uuid/compare/v1.0.0...v1.1.0) (2024-06-21)




### Bug Fixes:

* added tests for the workaround suggested to close #10

* require ash_postgres 2.0.11 or later

* Ash.Type.generator expects DataStream

## [v1.0.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.8.0-rc.1...v1.0.0) (2024-05-31)
### Breaking Changes:

* update to ash v3



## [v0.8.0-rc.1](https://github.com/zoonect-oss/ash_uuid/compare/v0.8.0-rc.0...v0.8.0-rc.1) (2024-04-03)




## [v0.8.0-rc.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.7.0...v0.8.0-rc.0) (2024-04-03)




### Features:

* Ash v3.0 RC support

## [v0.7.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.6.0...v0.7.0) (2024-01-24)




### Features:

* better support for elixir releases through new ash_uuid otp_app name config; resolve #6; minor bugfixes; deps ugrade

## [v0.6.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.5.0...v0.6.0) (2023-09-19)




### Features:

* add strict mode option

* add support for action's arguments; resolve #5; mimor bugfixes

## [v0.5.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.4.0...v0.5.0) (2023-08-20)




### Features:

* add supports for resources with embedded resources as attributes; resolve #4

## [v0.4.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.3.0...v0.4.0) (2023-08-13)




### Features:

* add supports for volatile and embedded resources; resolve #3

## [v0.3.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.2.2...v0.3.0) (2023-08-12)




### Features:

* add supports for many_to_many relationships and resources with relation to itself; resolve #1 and #2

### Bug Fixes:

* unsetting migration default for nullable fields

## [v0.2.2](https://github.com/zoonect-oss/ash_uuid/compare/v0.2.1...v0.2.2) (2023-08-09)




### Bug Fixes:

* update ash_postgres deps version with CustomExtension feature merged

## [v0.2.1](https://github.com/zoonect-oss/ash_uuid/compare/v0.2.0...v0.2.1) (2023-08-08)




## [v0.2.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.1.0...v0.2.0) (2023-08-08)




### Features:

* release preparation

## [v0.1.0](https://github.com/zoonect-oss/ash_uuid/compare/v0.1.0...v0.1.0) (2023-08-08)




### Features:

* structural types refactoring

* adds relationships support and postgres migration_defaults through transformers and formatter plugin

* postgres extension implementation

* first working types

### Bug Fixes:

* better default
