import Default from './autocomplete/default'
import Work from './autocomplete/work'
import LinkedData from './autocomplete/linked_data'

export default class AutocompleteExtension {
    // This is the initial setup for the form.
    setup (options) {
        var data = options.data
        var element = options.element
        switch (data.autocomplete) {
            case 'work':
                new Work(
                    element,
                    data.autocompleteUrl,
                    data.user,
                    data.id
                )
                break
            case 'linked_data':
                new LinkedData(element, data.autocompleteUrl)
                break
            default:
                new Default(element, data.autocompleteUrl)
                break
        }
    }
}
