Hyrax.autocomplete = function () {
    var AutocompleteExtension = require('hyrax/autocomplete_extension')
    var autocomplete = new AutocompleteExtension()

    $('[data-autocomplete]').each((function () {
        var data = $(this).data()
        autocomplete.setup({'element': $(this), 'data': data})
    }))

    $('.multi_value.form-group').manage_fields({
        add: function (e, element) {
            autocomplete.setup({'element': $(element), 'data': $(element).data()})
            // Don't mark an added element as readonly even if previous element was
            $(element).attr('readonly', false)
        }
    })
};
