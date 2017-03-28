module Hyrax
  module Renderers
    class FacetedPlusDbpediaDataAttributeRenderer < Hyrax::Renderers::FacetedAttributeRenderer
      def attribute_value_to_html(value)
        ret = super
        parts = value.split(', ')
        name = "#{parts.second}+#{parts.first}"
        lda = Qa::Authorities::LinkedData::GenericAuthority.new(:DBPEDIA)
        ld_results = lda.find name
        return ret if ld_results.nil? || !ld_results.kind_of?(Hash) || ld_results.empty?

        dbpedia_uri = ld_results[:uri]
        birthdate = ld_results['predicates']['http://dbpedia.org/ontology/birthDate'].first
        deathdate = ld_results['predicates']['http://dbpedia.org/property/deathDate'].first
        abstract =  ld_results['predicates']['http://dbpedia.org/ontology/abstract'].first

        ret.safe_concat "<div class='linked-data-alt-authority'>"
        ret.safe_concat "  (<i>source: <span class='glyphicon glyphicon-new-window'></span>&nbsp;#{auto_link(dbpedia_uri)}</i> )"
        ret.safe_concat "  <p class='data birthdate'>Birth: #{birthdate}</p>"
        ret.safe_concat "  <p class='data deathdate'>Death: #{deathdate}</p>"
        ret.safe_concat "  <p class='data abstract'>#{abstract}</p>"
        ret.safe_concat "</div>"
        ret
      end
    end
  end
end
