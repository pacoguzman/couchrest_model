# CouchRest::ExtendedDocument: CouchDB, not too close to the metal

CouchRest::ExtendedDocument adds additional functionality to the standard CouchRest Document class such as
setting properties, callbacks, typecasting, and validations.

Note: CouchRest only supports CouchDB 0.9.0 or newer.

## Install

    $ sudo gem install couchrest_extended_document
   
## Usage

    require 'couchrest/extended_document'

    class Cat < CouchRest::ExtendedDocument

      property :name, :type => String

    end

## Testing

The most complete documentation is the spec/ directory. To validate your
CouchRest install, from the project root directory run `rake`, or `autotest`
(requires RSpec and optionally ZenTest for autotest support).

## Docs

API: [http://rdoc.info/projects/couchrest/couchrest_extended_document](http://rdoc.info/projects/couchrest/couchrest_extended_document)

Check the wiki for documentation and examples [http://wiki.github.com/couchrest/couchrest](http://wiki.github.com/couchrest/couchrest)

## Contact

Please post bugs, suggestions and patches to the bug tracker at [http://github.com/couchrest/couchrest/issues](http://github.com/couchrest/couchrest/issues).

Follow us on Twitter: [http://twitter.com/couchrest](http://twitter.com/couchrest)

Also, check [http://twitter.com/#search?q=%23couchrest](http://twitter.com/#search?q=%23couchrest)
      
## Ruby on Rails

CouchRest is compatible with rails and can even be used a Rails plugin.
However, you might be interested in the CouchRest companion rails project:
[http://github.com/hpoydar/couchrest-rails](http://github.com/hpoydar/couchrest-rails)      
