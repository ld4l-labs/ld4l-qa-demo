# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models. 

  use_extension( Hydra::ContentNegotiation )

  def oclc_organization
    self[Solrizer.solr_name('oclc_organization')]
  end

  def oclc_organization_uri
    self[Solrizer.solr_name('oclc_organization_uri')]
  end

  def oclc_person
    self[Solrizer.solr_name('oclc_person')]
  end

  def oclc_person_uri
    self[Solrizer.solr_name('oclc_person_uri')]
  end

  def agrovoc_keyword
    self[Solrizer.solr_name('agrovoc_keyword')]
  end

  def agrovoc_keyword_uri
    self[Solrizer.solr_name('agrovoc_keyword_uri')]
  end

  def agrovoc_keyword_fr
    self[Solrizer.solr_name('agrovoc_keyword_fr')]
  end

  def agrovoc_keyword_fr_uri
    self[Solrizer.solr_name('agrovoc_keyword_fr_uri')]
  end
end
