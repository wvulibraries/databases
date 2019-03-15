# Databases 
[![Build Status](https://travis-ci.org/wvulibraries/databases.svg?branch=master)](https://travis-ci.org/wvulibraries/databases)
[![Maintainability](https://api.codeclimate.com/v1/badges/dc9fb3109c8a8ff1301c/maintainability)](https://codeclimate.com/github/wvulibraries/databases/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/dc9fb3109c8a8ff1301c/test_coverage)](https://codeclimate.com/github/wvulibraries/databases/test_coverage)

# DOCUMENTATION
- This project uses YARD for its documentation.  It will allow you a quick glimpse at documentation on all logic associated with the project.
- To regenerate documentation in the command line type `yard doc`.  

# USE AND CONFIGURATION 

## EMAILING FEATURES 
In `config/environments` the `development.rb` and `production.rb` files need to be modified.  Currently they point to WVU's mailservers and instead they should point to whatever email server you intend to use.  Also verifying ports and other settings should be setup to your specific needs.   

## CAPTCHA 
In `config/initialiers` the `recaptcha.rb` may have to be modified.  To get the proper captcha fields you should use the `V2 Api` using [google's recaptcha](https://www.google.com/recaptcha/) interface.

## CONFIGURABLE VARIABLES 
There are some configuration items that were setup to be easy to use and very configurable for anyone with little technical expierience.  These are in the `config/application.yml`.

### Variables 
- Proxy URL
- CAS Authentication 
- Time Zone
- Campus IP Range  
- Deault HelpText / HelpURL
- Emails 
