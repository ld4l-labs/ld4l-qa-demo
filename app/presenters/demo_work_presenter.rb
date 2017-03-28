# app/presenters/demo_work_presenter.rb
class DemoWorkPresenter < Hyrax::WorkShowPresenter
  delegate :oclc_organization, :oclc_organization_uri, :oclc_person, :oclc_person_uri, :agrovoc_keyword, :agrovoc_keyword_uri, :agrovoc_keyword_fr, :agrovoc_keyword_fr_uri, to: :solr_document
end
