# Linked Data in a Hyrax App

## Overview

This demo app shows the use of the [Questioning Authority linked_data branch](https://github.com/projecthydra-labs/questioning_authority/tree/linked_data) to use linked data 
authorities to select values for controlled vocabulary properties.  There are 3 preconfigured linked data authorities.  See the 
[QA README Linked Data section](https://github.com/projecthydra-labs/questioning_authority/tree/linked_data#linked-open-data-lod-authorities) for more information
on configurating authorities, making queries, and fetching a term.

The demo includes 3 fields:
* Oclc Organization - Uses OCLC FAST linked data authority limited to the CorporateName subauthority.  This field is used to 
demonstrate selection of a string.  The URI is not saved when the user makes a selection.  This is not a limitation of OCLC FAST and
the field can be configured to save the URI.
* Agrovoc Keyword - Uses FAO Agrovoc linked data authority to select an agriculture related keyword.  The URI is saved along with 
the label.  By default, Agrovoc is search using English.
* Agrovoc Keyword fr - Uses FAO Agrovoc linked data authority to select an agriculture related keyword in French.  The URI is saved
with the label.  This is included to demonstrate the ability to have multi-lingual access to authorities that have language support.  
In practice, you would want to based the language selection off the locale being used by the user.

---

## To use this app:

### Download and setup for use

1. clone from github
1. `bundle install`
1. `rake db:migrate`
1. Load workflows: `rake hyrax:workflow:load`
1. Create default admin set: `rake hyrax:default_admin_set:create`
1. Start server: `rails s`

### Create a work

1. Sign up a user: Login -> Sign up
1. Create a work: Works -> New Work
1. Type an organization name (e.g. cornell) into Oclc Organization field, wait for autocomplete list, and select a term label
1. Type an agricultural term (e.g. milk) into Agrovoc Keyword field, wait for autocomplete list, and select a term label
1. Type an agricultural term in French (e.g. lait) into Agrovoc Keyword fr field, wait for autocomplete list, and select a term label
1. Fill in all other required metadata and add a file
1. Save

### Validate selected metadata on work show page

1. see controlled vocabulary properties with selected labels and URIs
1. clicking the label will do a search within the app
1. clicking the URI will open the URI in the external authority


---

## To reproduce this app:

NOTES: 
* The early steps are the same for all Hyrax apps.  
  * If you already have a Hyrax app, you may want to jump ahead to section 3 on adding the properties. 
  * If you do NOT have a Hyrax app, be sure to read the Hyrax README carefully while creating the app.
* Each step listed here represents a single commit to this app.  You can view the commits in github to see how files changed with each commit.


### Step 1: Create the Hyrax app ([commit diffs](https://github.com/ld4l-labs/ld4l-qa-demo/commit/f24b1a6eb4c89c3fba96719f6659e558e70299de))

In this step, you are generating a Hyrax app.  At the end, you will be able to bring up the Hyrax app and view the home page.

* [follow prerequisite installs in Hyrax README instructions](https://github.com/projecthydra-labs/hyrax#getting-started)
* [generate the hyrax app following Hyrax README instructions](https://github.com/projecthydra-labs/hyrax#creating-a-hyrax-based-app)
* [add javascript runtime, if not already installed](https://github.com/projecthydra-labs/hyrax#javascript-runtime) - rubyracer or nodejs (requires bundle install if gems added)
* [load workflows following Hyrax README instructions](https://github.com/projecthydra-labs/hyrax#load-workflows)
* [create default admin set following Hyrax README instructions](https://github.com/projecthydra-labs/hyrax#create-default-administrative-set)

Test

* start server and test demo app at localhost:3000 - should bring up Hyrax app


### Step 2: Create demo_work ([commit diffs](https://github.com/ld4l-labs/ld4l-qa-demo/commit/ce93160de2d9892a200eb88ff943fef7892f583a))

In this step, you are creating a new work type with no customizations.  At the end of this step, you will have a work with default metadata fields.

* [generate the DemoWork work type following Hyrax README instructions](https://github.com/projecthydra-labs/hyrax#generate-a-work-type)

Test

* add a user -- Login -> Sign up
* add a demo work -- Works -> New Work (should show Add New Demo Work form)
* set required metadata and save


### Step 3: Add controlled vocabulary properties ([commit diffs](https://github.com/ld4l-labs/ld4l-qa-demo/commit/27e234ffab4ccd81fa1845d70a3772f1bd10bdf1))

In this step, you are adding custom properties that will have controlled values, but you not setting up the authority control yet.  At the end of this step, you will be able to type values into the property fields.

* follow instructions for [Customizing Metadata](https://github.com/projecthydra/sufia/wiki/Customizing-Metadata#add-the-new-single-value-property-to-the-model)
  * define properties in models
  * add to New/Edit form
  * add to show page

Test

* add a demo work -- Works -> New Work (confirm new properties are on the form)
* set string values in new properties
* save
* confirm properties and values are displayed on the show page


### Step 4: Use QA linked data authorities for agrovoc keywords and oclc organizations ([commit diffs](https://github.com/ld4l-labs/ld4l-qa-demo/commit/f4d05d93260ce3a78ec6be7bb5e89284e680ed12))

In this step, you are setting up the controlled vocabularies for autocompletion.  At the end of this step, the string values will be saved for each controlled vocabulary property.  The URIs are not being saved yet.

* use linked_data branch of QA gem
* use linkeddata gem (dev and test only)
* add app/views/records/edit_fields for both properties to use autocomplete

Test

* add a demo work -- Works -> New Work
* type cornell in OCLC field (confirm an autocomplete list is shown below the field)
* type milk in Agrovoc field (confirm an autocomplete list is shown below the field)
* type lait in Agrovoc (French) field (confirm an autocomplete list is shown below the field)
* complete rest of required metadata and add a file
* save
* confirm that selected values are in the controlled properties on the show page


### Step 5: Save URI along with Label for Agrovoc controlled vocabulary ([commit diffs](https://github.com/ld4l-labs/ld4l-qa-demo/commit/f04133b45c2d0360fc0004eed44098f046857271))

In this step, you are are modifying the multi_value input class to be able to add a readonly uri field that corresponds 
to each linked data autocomplete field designated to use the 'linked_data' autocomplete process.  You are also adding javascript
that populates the URI and Label fields when an autocomplete selection is made.  The URI fields are displayed on the work show 
page with links to the external authority.  At the end of this step, the string values and URIs are saved and displayed for both
Agrovoc controlled vocabulary properties.  The OCLC FAST based property does not save the URI.  This is to demonstrate that 
saving the URI is optional.

NOTE: It is anticipated that some of the steps in this commit will become part of Hyrax and will not have to be added by the app.
This will likely include all the javascript and the modifications to the multi_value input class.

* add javascript for setting URI in uri field when label is selected during autocomplete
* add readonly URI field to form when data[‘autocomplete’] == ‘linked_data’
* display uri fields on work show page linked out to authority

Test

* add a demo work -- Works -> New Work
* type cornell in OCLC field (confirm an autocomplete list is shown below the field)
* type milk in Agrovoc field (confirm an autocomplete list is shown below the field)
* type lait in Agrovoc (French) field (confirm an autocomplete list is shown below the field)
* complete rest of required metadata and add a file
* save
* confirm that selected values are in the controlled properties on the show page along with external links for the URIs of the agrovoc properties


### Step 6: Leverage linked data on show page

In this step, you are using standard renderers and adding custom renderers for the show page to add special display code for two linked data fields:
   
1. use existing renderer to render string label as facet
1. use existing renderer to render uri as external link to the original authority
1. add custom renderer to render string label as a facet and uri as an external link plus include label and uri for each narrower, broader, and sameas predicate
1. add custom renderer to render string label as a facet and include external information from dbpedia

Test

* view the show page for previously saved work
* confirm that OCLC Organization has a faceted link for the field value that searches Hyrax for other works with the same value
* confirm that Agrovoc Keyword fr URI has an external link that goes to the Agrovoc authority show page for the URI
* confirm that Agrovoc Keyword has a faceted link for the label and an external link to Agrovoc for the URI
* confirm that Agrovoc keyword has narrower, broader, and sameas labels and URIs
* confirm that OCLC Person has a faceted link for the field value and additional information (e.g. birth, death, and abstract) from dbpedia


### Full Disclosure

The following is the state of the show page renderers used in this app.

* WORKS faceted link for label string value (defined in Hyrax)
* WORKS external link for URI (defined in Hyrax)
* NEEDS IMPROVEMENT custom renderer for additional predicates (e.g. narrower, broader, sameas) available from the term.  This works well if the number of additional predicates is relatively small (e.g. < 10).  If it grows too large, it can become a performance issue.  Each additional predicate requires a request from the authority to get the label value associated with the predicate.
* KLUDGE custom renderer to get additional information from dbpedia.  I make use of the fact that dbpedia uses the person name as the resource id.  I parse the name from OCLC to make an educated guess at the dbpedia resource id.  Sometimes it works; sometimes not.
