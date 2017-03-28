module Hyrax
  module Renderers
    class FacetedLinkedDataAttributeRenderer < Hyrax::Renderers::ExternalLinkAttributeRenderer
      def attribute_value_to_html(value)
        uri_link = super

        lda = Qa::Authorities::LinkedData::GenericAuthority.new(:AGROVOC)
        ld_results = lda.find agrovoc_id value
        return uri_link if ld_results.nil? || !ld_results.kind_of?(Hash) || ld_results.empty?

        label_link = faceted_attribute_value_to_html(ld_results[:label])
        ret = label_link
        ret.concat("  ")
        ret.concat(uri_link)

        narrower_uris = ld_results[:narrower]
        broader_uris = ld_results[:broader]
        sameas_uris = ld_results[:sameas]

        ret.safe_concat "<div class='linked-data-additional_uris'>"
        # ret.safe_concat render_uris("uri", [value])
        ret.safe_concat render_uris("narrower", narrower_uris, lda)
        ret.safe_concat render_uris("broader", broader_uris, lda)
        ret.safe_concat render_uris("sameas", sameas_uris)
        ret.safe_concat "</div>"
        ret
      end

      private
        def faceted_attribute_value_to_html label
          label_li_value(label.first)
        end

        def agrovoc_id uri
          uri.split("/").last
        end

        def render_uris label, uris, lda=nil
          return "" if uris.nil? || !uris.kind_of?(Array) || uris == [""]
          link_html = "<p>"
          uris.each do |uri|
            link_html.concat "  #{label}: #{uri_label(lda, uri)}  <span class='glyphicon glyphicon-new-window'></span>&nbsp\;#{auto_link(uri)}</br>"
          end
          link_html.concat "</p>"
        end

        def uri_label lda, uri
          return if lda.nil? || uri.nil?
          ld_results = lda.find agrovoc_id uri
          label = ld_results[:label].first
          return " #{label_li_value(label)}  " unless label.nil? || !label.length.positive?
          ""
        end

        def label_li_value(value)
          link_to(ERB::Util.h(value), search_path(value))
        end

        def search_path(value)
          Rails.application.routes.url_helpers.search_catalog_path(:"f[#{search_field}][]" => ERB::Util.h(value))
        end

        def search_field
          ERB::Util.h(Solrizer.solr_name(options.fetch(:search_field, label_field_sym), :facetable, type: :string))
        end

        def label_field_sym
          label_field = field.to_s
          label_field.slice!("_uri")
          label_field.to_sym
        end
    end
  end
end
