class MultiValueInput < SimpleForm::Inputs::CollectionInput
  def input(wrapper_options)
    @rendered_first_element = false
    input_html_classes.unshift('string')
    input_html_options[:name] ||= "#{object_name}[#{attribute_name}][]"
    outer_wrapper do
      buffer_each(collection) do |value, index|
        inner_wrapper do
          build_field(value, index)
        end
      end
    end
  end

  protected

  def buffer_each(collection)
    collection.each_with_object('').with_index do |(value, buffer), index|
      buffer << yield(value, index)
    end
  end

  def outer_wrapper
    "    <ul class=\"listing\">\n        #{yield}\n      </ul>\n"
  end

  def inner_wrapper
    <<-HTML
          <li class="field-wrapper">
            #{yield}
          </li>
    HTML
  end

  private

  # Although the 'index' parameter is not used in this implementation it is useful in an
  # an overridden version of this method, especially when the field is a complex object and
  # the override defines nested fields.
  def build_field_options(value, index)
    options = input_html_options.dup

    options[:value] = value
    if @rendered_first_element
      options[:id] = nil
      options[:required] = nil
    else
      options[:id] ||= input_dom_id
    end
    options[:class] ||= []
    options[:class] += ["#{input_dom_id} form-control multi-text-field"]
    options[:'aria-labelledby'] = label_id
    @rendered_first_element = true

    options
  end


  def build_label_field_options(value, index)
    options = input_html_options.dup
    options[:id] ||= "#{input_dom_id}_#{index}"
    options[:value] = value
    options[:required] = nil if @rendered_first_element
    options[:class] ||= []
    options[:class] += ["#{input_dom_id} form-control multi-text-field ui-linkeddata-autocomplete-input"]
    options[:'aria-labelledby'] = label_id
    @rendered_first_element = true
    options
  end

  def build_uri_field_options(value, index)
    options = input_html_options.dup
    options[:id] ||= "#{input_dom_id}_uri_#{index}"
    options[:name] = uri_field_name
    options[:value] = value
    options[:required] = nil if @rendered_first_element
    options[:readonly] = true
    options[:class] ||= []
    options[:class] += ["#{uri_input_dom_id} form-control multi-text-field"]
    options.delete :data
    options[:'aria-labelledby'] = uri_label_id
    @rendered_first_element = true
    options
  end

  def build_label_and_uri_fields(value, index)
    label_options = build_label_field_options(value,index)
    uri_options = build_uri_field_options(value,index)
    label_field = @builder.text_field(attribute_name, label_options)
    uri_field = @builder.text_field(uri_attribute_name, uri_options)
    "#{label_field}\n#{uri_field}"
  end

  def build_field(value, index)
    options = build_field_options(value, index)
    if show_uri
      options.delete(:type)
      build_label_and_uri_fields(value, index)
    elsif options.delete(:type) == 'textarea'.freeze
      @builder.text_area(attribute_name, options)
    else
      @builder.text_field(attribute_name, options)
    end
  end

  def label_id
    input_dom_id + '_label'
  end

  def uri_label_id
    input_dom_id + '_uri_label'
  end

  def uri_field_name
    "#{object_name}[#{uri_attribute_name}][]"
  end

  def input_dom_id
    input_html_options[:id] || "#{object_name}_#{attribute_name}"
  end

  def uri_input_dom_id
    input_html_options[:uri_id] || "#{object_name}_#{uri_attribute_name}"
  end

  def collection
    @collection ||= begin
      val = object[attribute_name]
      col = val.respond_to?(:to_ary) ? val.to_ary : val
      col.reject { |value| value.to_s.strip.blank? } + ['']
    end
  end

  def multiple?; true; end

  def show_uri
    # return true if(input_html_options.key?(:data) && input_html_options[:data].key?('autocomplete-method') && input_html_options[:data]['autocomplete-method'] == :linked_data)
    return true if(input_html_options.key?(:data) && input_html_options[:data].key?('autocomplete') && input_html_options[:data]['autocomplete'] == 'linked_data')
    false
  end

  def uri_attribute_name
    if(input_html_options.key?(:data) && input_html_options[:data].key?('autocomplete-uri-name') && !input_html_options[:data]['autocomplete-uri-name'].nil?)
      return input_html_options[:data]['autocomplete-uri-name']
    end
  end

end


