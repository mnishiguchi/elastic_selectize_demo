// About Browserify
// ----------------
// + https://github.com/substack/browserify-handbook#exports

// About Selectize
// ---------------
// + https://github.com/selectize/selectize.js/tree/master/docs
// + https://selectize.github.io/selectize.js/#demo-github
// + https://github.com/selectize/selectize.js/blob/master/examples/github.html

// http://stackoverflow.com/a/32082914/3837223
window.require = require;

// Specify the selector of the element that will be selectized.
const elementSelector = '#selectize_featured_properties';

let selectizeObject = null;


// ---
// PUBLIC INTERFACE
// ---


/**
 * Sets up the selectize and stores the reference to the selectize object.
 */
function selectizeFeaturedProperties() {
  console.log("selectizeFeaturedProperties");

  // Reject if there is no element with the elementSelector in DOM.
  if (!elementExist(elementSelector) ) { return; }

  // De-allocate if selectize has already been instantiated.
  if (selectizeObject) {
    selectizeObject.destroy();
  }

  // https://github.com/selectize/selectize.js/blob/master/docs/usage.md#data_searching
  const $selectizedElement = $(elementSelector).selectize({
      valueField   : 'property_container_name', // For the values to submit.
      labelField   : 'property_container_name', // For the tags in the input field.
      searchField  : ['property_container_name', 'notes'],
      render       : { option: renderOption },
      load         : load,
      onLoad       : onLoad,
      onChange     : onChange,
      preload      : false,
      placeholder  : "Type a keyword and select...",
  })[0];

  // Store the reference to the selectize instance.
  // https://github.com/selectize/selectize.js/blob/master/docs/api.md#selectize-api
  selectizeObject = $selectizedElement.selectize;

  // Set up the clear button.
  $('button[type="reset"]').on('click', function(){
    selectizeObject.clear();
  });
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

function onChange(value) {
  console.log("selectizeFeaturedProperties:onChange => ", value);
  $('button[type="submit"]').click();
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
