# Generated via
#  `rails generate hyrax:work DemoWork`
class DemoWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::Hyrax::BasicMetadata
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }
  
  self.human_readable_type = 'Demo Work'

  property :oclc_organization_uri, predicate: ::RDF::URI.new('http://www.example.org/ns#oclc_org'), multiple: true
  property :oclc_organization, predicate: ::RDF::URI.new('http://www.example.org/ns#oclc_org_label'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end

  # TODO: URI probably doesn't need to be stored_searchable, but I couldn't get it to show up on the show page for the work with out this
  property :agrovoc_keyword_uri, predicate: ::RDF::URI.new('http://www.example.org/ns#agrovoc_keyword'), multiple: true do |index|
    index.as :stored_searchable
  end
  property :agrovoc_keyword, predicate: ::RDF::URI.new('http://www.example.org/ns#agrovoc_keyword_label'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end

  # TODO: same issue as agrovoc_keyword_uri
  property :agrovoc_keyword_fr_uri, predicate: ::RDF::URI.new('http://www.example.org/ns#agrovoc_keyword_fr'), multiple: true do |index|
    index.as :stored_searchable
  end
  property :agrovoc_keyword_fr, predicate: ::RDF::URI.new('http://www.example.org/ns#agrovoc_keyword_label_fr'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end

  property :loc_name_uri, predicate: ::RDF::URI.new('http://www.example.org/ns#loc_name'), multiple: true
  property :loc_name, predicate: ::RDF::URI.new('http://www.example.org/ns#loc_name_label'), multiple: true do |index|
    index.as :stored_searchable, :facetable
  end
end
