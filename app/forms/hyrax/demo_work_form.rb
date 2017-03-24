# Generated via
#  `rails generate hyrax:work DemoWork`
module Hyrax
  class DemoWorkForm < Hyrax::Forms::WorkForm
    self.model_class = ::DemoWork
    self.terms += [:resource_type, :oclc_organization, :agrovoc_keyword, :agrovoc_keyword_fr, :loc_name]
    self.required_fields += [:oclc_organization, :agrovoc_keyword, :agrovoc_keyword_fr]
  end
end
