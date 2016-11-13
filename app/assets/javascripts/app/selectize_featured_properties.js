// About Browserify
// + https://github.com/substack/browserify-handbook#exports

// About Selectize
// + https://github.com/selectize/selectize.js/tree/master/docs
// + https://selectize.github.io/selectize.js/#demo-github
// + https://github.com/selectize/selectize.js/blob/master/examples/github.html

// http://stackoverflow.com/a/32082914/3837223
window.require = require;

// Store the reference to the selectize instance.
let selectize = null;

const elementSelector = '#q.selectize_featured_properties';


// ---
// PUBLIC FUNCTIONS
// ---


/**
 * Sets up the selectize and stores the reference to the selectize object.
 */
function selectizeFeaturedProperties() {
  console.log("selectizeFeaturedProperties");

  if (selectize) { return; }
  if ( !elementExist(elementSelector) ) { return; }

  // https://github.com/selectize/selectize.js/blob/master/docs/usage.md#data_searching
  const $elem = $(elementSelector).selectize({
      valueField : 'property_container_id',
      labelField : 'property_container_name',
      searchField: 'property_container_name',
      render     : { option: renderOption },
      load       : load,
      onLoad     : onLoad,
  });

  selectize = $elem[0].selectize;
}


// ---
// PRIVATE FUNCTIONS
// ---


function elementExist(elementSelector) {
  return $(elementSelector).length;
}

function load(query, callback) {
    if (!query.length) { return callback(); }

    $.ajax({
        url: `../featured_properties/autocomplete.json?q=${encodeURIComponent(query)}`,
        type: 'GET',
        error: reason => {
            callback(reason);
        },
        success: res => {
            console.log(res.results)
            callback(res.results.slice(0, 10));
        }
    });
}

function onLoad(data) {
  console.log("selectizeFeaturedProperties:onLoad");
}

function renderOption(item, escape) {
    console.log("selectizeFeaturedProperties:renderOption");

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
}

module.exports = selectizeFeaturedProperties;
