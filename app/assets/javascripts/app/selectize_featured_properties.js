window.require = require;

const selectizeInput = require('./selectize_input');

function selectizeFeaturedProperties(initialItems=[]) {

    selectizeInput({
        pageSelector           : '#featured_properties_index',
        selectizeInputSelector : '#property_container_name',
        transformationSelector : '.selectize-control',
        valueField             : 'property_container_name', // For the values to submit.
        labelField             : 'property_container_name', // For the tags in the input field.
        searchField            : [ 'property_container_name', 'notes' ],
        initialItems           : initialItems,
        autocompletePath       : '/featured_properties/autocomplete.json',
        placeholder            : "Type a keyword and select...",
        optionListTemplate     : function (item, escape) {
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
