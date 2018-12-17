# Databases 

# Scaffold and Generate Commands 

## Base Generated Scaffolds from the Schema
- bin/rails generate model AccessPlainText name:text --no-migration

- bin/rails generate model AccessType name:string --no-migration

- bin/rails generate scaffold Admin::Database name:string status:integer years_of_coverage:string url:string off_campus_url:string updated:string full_text_db:integer new_database:integer trial_database:integer help:text help_url:text description:text created_date:integer updated_date:integer popular:integer trial_expire_date:integer alumni:integer title_search:string --no-migration

- bin/rails generate scaffold DatabaseStatus name:string --no-migration

- bin/rails generate model DatabaseCurations database:references subject:references sort:integer --no-migration

- bin/rails generate scaffold DatabasesResourceType database:references resource:references --no-migration

- bin/rails generate scaffold DatabasesSubject database:references subject:references --no-migration

- bin/rails generate scaffold IpLocation ip_range:string name:string --no-migration

- bin/rails generate scaffold News name:string --no-migration

- bin/rails generate scaffold ResourceType name:string --no-migration

- bin/rails generate scaffold Statistic dbID:integer location:integer access_date:integer referrer:string ip_address:string --no-migration

- bin/rails generate scaffold Subject name:string url:string --no-migration

- bin/rails generate scaffold UpdateText name:string --no-migration

- bin/rails generate model Vendor name:string url:string --no-migration

# Development Notes 

# OLD APP FUNCTIONALITY

## CONNECT.PHP 
This is the heart of the "stable url" in the databases application. The URL_ID is the unique identifier for all of the databases.  If you click on a URL it will look at where you are and what access conditions need to be met, then create the URL for your use case and forward you to the appropriate URL.  The easiest use case as I can tell so far is if your on campus it sends you to the URL, if your off campus and off campus use is allowed it sends you to a proxyURL that allows you to sign in appropriately.  

### Access / access_types 
This is oddly written in the old application.  The connect.php file handles this along with the URLByID that grabs a string of intergers from the database that is custom to each database, then forwards the user to the appropriate database.

The access types are the interesting bit here, it really only checks 2 things.  The first is the location, `$location = (ipAddr::onsite())?1:0;` to determine if the browser is on campus or not, then if the `access_type` id is less than 2 and the user is not on campus then it sends a message that the database is only avaliable on campus. 

Assuming the location is off campus or doesn't match the ip configurations, a proxy url is added onto the URL.  This also includes the access_type id being number 2. 
`$url = sprintf("%s%s",$localvars->get("proxyURL"),$url);` 

If neither of those conditions are met, it simply goes to the database URL which seems odd to me, but maybe that is expected functionality.  

#### Access Types 
```
[1, \"Campus Only for some titles\"], 
[2, \"Campus and Remote (Requires WVU Login)\"], 
[3, \"Unrestricted Access (No Login Required)\"], 
[28, \"Password Access for Alumni\"], 
[30, \"Downtown Library Only\"], 
[32, \"Off-Campus Requires Account\"], 
[33, \"Create password with a WVU email address\"], 
[34, \"WVU MyID to read or listen\"], 
[35, \"Create Account with WVU Email\"]
``` 

#### Access Plain Text 
This seems to only be used in the forms and may hold no real use case value.  It is going to need to be investigated as to what that was meant to be used for and what the actual use of it currently is.  

Current Use: There are references of accessPlainText only in the menus and in the administration form.  This appears to be *deprecated*. 

## Database Stats 

Statistics are being kept on each database by which database the user is trying to access.  These statistics simply contains the dbID, location, access date, referrer, nad ip address. 
