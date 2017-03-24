export default class LinkedData {
    constructor(element, url) {
        this.url = url;
        element.autocomplete(this.options(element));
    }
    options(element) {
        return {
            minLength: 2,
            source: (request, response) => {
                $.getJSON(this.url, {
                    q: request.term
                }, response );
            },
            focus: function() {
                // prevent value inserted on focus
                return false;
            },
            complete: function(event) {
                $('.ui-autocomplete-loading').removeClass("ui-autocomplete-loading");
            },
            select: function(event, ui) {
                if (element.data('autocomplete-read-only') === true) {
                    element.attr('readonly', true);
                }

                // find uri element and populate it
                var parts = element.context.id.split('_');  // assumes element is the real element object for the label field
                var index = parts.splice(-1,1)[0];
                var base = parts.join('_');

                var uri_element_id = base + '_uri_' + index;
                var uri_element = document.getElementById(uri_element_id);
                uri_element.value = ui.item.uri;
            }
        };
    }
}
