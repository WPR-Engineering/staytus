# Staytus Change Log

This file outlines the key changes between different revisions. The `stable`
branch will always contain the latest released version. Each version will
be tagged as appropriate.

Any version number which is suffixed by `-dev` means that it is currently
being developed and is not yet released. It is most likely you'll only ever
see this in a master branch.

<<<<<<< HEAD
## v1.3.0

* Upgrade underlying Rails version to 5.1
=======
## v1.0.0 - WPR
* Initial release with modifications from WPR
* added email list support
* changed from ENV config values to using a config file (app-config.yml)
  - this was to support shared hosting environments
>>>>>>> stable

## v1.2.0

* Allow services to be grouped
* Allow subscribers to be added through the admin interface

## v1.0.1

* Allow services to have a description which will be displayed on the
  default theme.
* Add API tokens to allow services to authenticate to the API.
* Add `services/all` API method - for list all services with current status.
* Add `services/info` API method - to return details about a specific API method.
* Add `services/set_status` API method - to set the status for a specific service.

## v1.0.0

* Initial Release
