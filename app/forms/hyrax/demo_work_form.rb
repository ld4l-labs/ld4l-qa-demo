# Generated via
#  `rails generate hyrax:work DemoWork`
module Hyrax
  class DemoWorkForm < Hyrax::Forms::WorkForm
    self.model_class = ::DemoWork
    self.terms += [:resource_type, :oclc_organization, :oclc_organization_uri, :agrovoc_keyword, :agrovoc_keyword_uri, :agrovoc_keyword_fr, :agrovoc_keyword_fr_uri, :loc_name, :loc_name_uri]
    self.required_fields += [:oclc_organization, :agrovoc_keyword, :agrovoc_keyword_fr]

    def primary_terms
      # Prevent URIs from being displayed by hydra-editor.  They are displayed paired with their corresponding label fields.
      required_fields - [:oclc_organization_uri, :agrovoc_keyword_uri, :agrovoc_keyword_fr_uri, :loc_name_uri]
    end
  end
end
