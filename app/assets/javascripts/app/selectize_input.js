// http://stackoverflow.com/a/32082914/3837223
window.require = require;

// ==> About Browserify
// ----------------
// + https://github.com/substack/browserify-handbook#exports

// ==> About Selectize
// ---------------
// + https://github.com/selectize/selectize.js/tree/master/docs
// + https://selectize.github.io/selectize.js/#demo-github
// + https://github.com/selectize/selectize.js/blob/master/examples/github.html

// ==> Making Transformations Idempotent
// https://github.com/turbolinks/turbolinks#making-transformations-idempotent
// ---------------
// We need to detect whether selectize has already been initialized so that we
// can avoid duplicate selectize controls. See `isAlreadyTransformed()`.

// ==> Usage
// ---------------
// const selectizeInput = require('./selectize_input');
//
// function selectizeFeaturedProperties(initialItems=[]) {
//     selectizeInput({
//         pageSelector           : '#featured_properties_index',
//         selectizeInputSelector : '#property_container_name',
//         transformationSelector : '.selectize-control',
//         valueField             : 'property_container_name', // For the values to submit.
//         labelField             : 'property_container_name', // For the tags in the input field.
//         searchField            : [ 'property_container_name', 'notes' ],
//         initialItems           : initialItems,
//         autocompletePath       : '/featured_properties/autocomplete.json',
//         placeholder            : "Type a keyword and select...",
//         optionListTemplate     : function (item, escape) {
//             return (`
//                 <div>
//                   <span class="title">
//                     <span class="name">${escape(item.property_container_name)}</span>
//                   </span>
//                   <span class="notes">
//                     ${escape(item.notes)}
//                   </span>
//                   <ul class="meta">
//                     <li class="created_at">
//                       <span>${escape(item.created_at)}</span>
//                     </li>
//                     <li class="updated_at">
//                       <span>${escape(item.updated_at)}</span>
//                     </li>
//                   </ul>
//                 </div>
//             `);
//         },
//     });
// }

let pageSelector;
let selectizeInputSelector;
let transformationSelector;
let labelField;
let valueField;
let autocompletePath;


// ---
// PUBLIC INTERFACE
// ---


/**
 * Sets up the selectize and stores the reference to the selectize object.
 */
function selectizeInput(params) {
    console.log("selectizeInput");

    // Store the references to selectors.
    pageSelector           = params.pageSelector;
    selectizeInputSelector = params.selectizeInputSelector;
    transformationSelector = params.transformationSelector;
    labelField             = params.labelField;
    valueField             = params.valueField;
    autocompletePath       = params.autocompletePath;

    // Reject if there is no element with the selectizeInputSelector in DOM.
    if (!selectorExists()) { return; }

    // Reject if the selectize has already been initialized.
    // NOTE: This is important to avoid initializing selectize twice.
    if (isAlreadyTransformed()) { return; }

    let items = getCurrentlySelectedItems();

    // https://github.com/selectize/selectize.js/blob/master/docs/usage.md#data_searching
    // https://github.com/selectize/selectize.js/blob/master/docs/api.md#selectize-api
    const selectizeObject = $(selectizeInputSelector).selectize({
        valueField  : params.valueField, // For the values to submit.
        labelField  : params.labelField, // For the tags in the input field.
        searchField : params.searchField,
        options     : params.initialItems,
        items       : items,
        render      : { option: params.optionListTemplate },
        load        : load,
        onChange    : onChange,
        placeholder : params.placeholder,
    })[0].selectize;

    // Trigger submit when selectboxes are changed.
    $(`${pageSelector} select`).on('change', submit);

    // Add loading message when submit button is clicked.
    $(selectizeInputSelector).on('submit', () => {
        updateQueryStringAndReplaceState();
        showLoadingMessage();
    });
}


// ---
// PRIVATE FUNCTIONS
// ---


/**
 * Reads a list of currently selected items from the query string.
 * @return {array<string>} a list of item names.
 */
function getCurrentlySelectedItems() {
  const urlParams = new URLSearchParams(window.location.search);

  if (urlParams.get(valueField)) {
      return urlParams.get(valueField).split(',');
  }
}

function selectorExists() {
    return $(selectizeInputSelector).length;
}

// https://github.com/turbolinks/turbolinks#making-transformations-idempotent
function isAlreadyTransformed() {
    return $(transformationSelector).length;
}

function updateQueryStringAndReplaceState() {
    // Generate a query string for the current form state.
    const queryString = $(`${pageSelector} form`).serialize();

    // Update the query string.
    history.replaceState(history.state, '', `?${queryString}`);
    return queryString;
}

function submit() {
    $(selectizeInputSelector).submit();
}

function load(query, callback) {
    if (!query.length) { return callback(); }

    $.ajax({
        url: `${autocompletePath}?q=${encodeURIComponent(query)}`,
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

function showLoadingMessage() {
    $('#search_result table').append(`
        <div style="position:absolute;top:0;left:0;width:100%;height:100%;background:rgba(255,255,255,0.4);">
          <div class="h2" style="color:#666;position:absolute;top:40vh;left:40vw;">
            <i class="fa fa-cog fa-spin fa-3x fa-fw"></i>
            <span class="sr-only">Loading...</span>
            Loading...
          </div>
        </div>
    `);
}

function onChange(value) {
    console.log("selectizeInput:onChange => ", value);
    submit();
}

module.exports = selectizeInput;
