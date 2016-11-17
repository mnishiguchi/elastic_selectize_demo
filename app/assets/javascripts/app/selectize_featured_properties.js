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
const pageSelector              = '#featured_properties_index'
const selectizedElementSelecter = '#property_container_name';
const valueField                = 'property_container_name';

let selectizeObject = null;


// ---
// PUBLIC INTERFACE
// ---


/**
 * Sets up the selectize and stores the reference to the selectize object.
 */
function selectizeFeaturedProperties() {
  console.log("selectizeFeaturedProperties");

  // Reject if there is no element with the selectizedElementSelecter in DOM.
  if (!$(selectizedElementSelecter).length) { return; }

  // https://github.com/selectize/selectize.js/blob/master/docs/usage.md#data_searching
  // https://github.com/selectize/selectize.js/blob/master/docs/api.md#selectize-api
  selectizeObject = $(selectizedElementSelecter).selectize({
      valueField   : valueField, // For the values to submit.
      labelField   : valueField, // For the tags in the input field.
      searchField  : [valueField, 'notes'],
      render       : { option: renderOption },
      load         : load,
      onLoad       : onLoad,
      onChange     : onChange,
      placeholder  : "Type a keyword and select...",
  })[0].selectize;


  // Trigger submit when selectboxes are changed.
  $(`${pageSelector} select`).on('change', submit);

  // Add loading message when submit button is clicked.
  $(selectizedElementSelecter).on('submit', function(){
    $('#search_result table').append(`
      <div style="position:absolute;top:0;left:0;width:100%;height:100%;background:rgba(255,255,255,0.4);">
        <div class="h2" style="color:#666;position:absolute;top:40vh;left:40vw;">
          <i class="fa fa-cog fa-spin fa-3x fa-fw"></i>
          <span class="sr-only">Loading...</span>
          Loading...
        </div>
      </div>
    `);
  });
}


// ---
// PRIVATE FUNCTIONS
// ---


// function clearSelectTag(selectizedElementSelecter) {
//   document.querySelector(selectizedElementSelecter).selectedIndex = 0;
// }

// function elementExist(selectizedElementSelecter) {
//   return $(selectizedElementSelecter).length;
// }

// function clearQueryString() {
//   history.pushState(null, "", location.href.split("?")[0]);
// }


function submit() {
    $(selectizedElementSelecter).submit();
}

function load(query, callback) {
    if (!query.length) { return callback(); }

    $.ajax({
        url: `../featured_properties/autocomplete.json?q=${encodeURIComponent(query)}`,
        type: 'GET',
        error: reason => {
            console.error(reason);
            callback();
        },
        success: res => {
            console.log(res.results);
            callback(res.results.slice(0, 10));
        }
    });
}

function onLoad(data) {
  console.log("selectizeFeaturedProperties:onLoad");
}

function onChange(value) {
  console.log("selectizeFeaturedProperties:onChange => ", value);
  $(selectizedElementSelecter).submit();
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
