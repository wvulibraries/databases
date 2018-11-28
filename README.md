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