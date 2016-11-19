// http://stackoverflow.com/a/32082914/3837223
window.require = require;

const initializeSelectize = require('./initialize_selectize');

function selectizeFeaturedProperties(initialOptionItems=[]) {

    initializeSelectize({
        initialOptionItems: initialOptionItems,
        selectors         : {
                              scope          : '#featured_properties_index',
                              selectizeInput : '#property_container_name',
                              transformation : '.selectize-control',
                              searchResult   : '#search_result',
        },
        valueField        : 'property_container_name', // For the values to submit.
        labelField        : 'property_container_name', // For the tags in the input field.
        searchField       : [ 'property_container_name', 'notes' ],
        autocompletePath  : '/featured_properties/autocomplete.json',
        placeholder       : 'Type a keyword and select...',
        optionListTemplate: function (item, escape) {
            return (`
                <div>
                  <span class="title">
                    <span class="name">${escape(item.property_container_name)}</span>
                  </span>
                  <span class="notes">
                    ${escape(item.notes)}
                  </span>
                  <ul class="meta">
                    <li class="created_at">
                      <span>${escape(item.created_at)}</span>
                    </li>
                    <li class="updated_at">
                      <span>${escape(item.updated_at)}</span>
                    </li>
                  </ul>
                </div>
            `);
        },
    });
}

module.exports = selectizeFeaturedProperties;
