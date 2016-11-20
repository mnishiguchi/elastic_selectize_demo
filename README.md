# Elastic selectize demo

## Assumptions
+ Rails 5 with turbolinks and browserify-rails.
+ We submit the form by Ajax with the `remote` option set to `true`.
+ We use selectize.js that transforms the the input field to a suggestion list.
+ A query string always reflects the current state of the form values.
+ We want to trigger the form submission when any change in form input values.
+ We want to replace history every time the form is submitted.
+ We can navigate through the history back and forth and each page shows as
the query string indicates.

---

## Libraries used

#### Transpiling ES6+
- Powered by [browserify-rails](https://github.com/browserify-rails/browserify-rails)

#### Smooth page transition
- Powered by [turbolinks](https://github.com/turbolinks/turbolinks) and [rails.js](https://github.com/rails/jquery-ujs/blob/master/src/rails.js)

#### Search functionality
- Powered by [ankane/searchkick](https://github.com/ankane/searchkick)

#### Autocomplete functionality
- Powered by [selectize.js](https://selectize.github.io/selectize.js/)
- [https://github.com/selectize/selectize.js/tree/master/docs](https://github.com/selectize/selectize.js/tree/master/docs)
- [https://selectize.github.io/selectize.js/#demo-github](https://selectize.github.io/selectize.js/#demo-github)
- [https://github.com/selectize/selectize.js/blob/master/examples/github.html](https://github.com/selectize/selectize.js/blob/master/examples/github.html)

#### Updating the query string that reflects the current form state
- Powered by [jQuery .serialize()](http://api.jquery.com/serialize/) and [history API](https://developer.mozilla.org/en-US/docs/Web/API/History_API)

```js
function updateQueryStringAndReplaceState() {
    // Generate a query string for the current form state.
    const queryString = $(`${config.selectors.scope} form`).serialize();

    // Update the history for the current page.
    history.replaceState(history.state, '', `?${queryString}`);
}
```

#### Simple loaders using only one div and pure CSS
- Powered by [raphaelfabeni/css-loader](https://github.com/raphaelfabeni/css-loader)

---

## Gotchas
#### [Making Transformations Idempotent](https://github.com/turbolinks/turbolinks#making-transformations-idempotent)

When we use third-party javascript libraries, we should detect if their code is
already initialized so that we can avoid them from constructing duplicate elements.

```js
function isAlreadyTransformed() {
    // Detect the existence of the transformationSelector in the DOM.
    return $(config.selectors.transformation).length;
}
```

```js
function initializeSelectize(params) {
    //...

    // Reject if there is no element with the selectizeInputSelector in DOM.
    // Reject if the selectize has already been initialized.
    // NOTE: This is important to avoid initializing selectize twice.
    if (!selectizeInputSelectorExists() || isAlreadyTransformed()) { return; }

    //...
```

---

## Get started

```
rails db:create
rails db:migrate
rails db:seed        
```

```
npm install
```

```
elasticsearch
```

```
rails s
```

Visit localhost:3000

---

## search form for selectize

```slim
= form_tag featured_properties_path, method: :get, remote: true do |f|
  input#selectize_featured_properties [name="property_container_name"]
```

#### The `input` tag
- Determine the `id` for that tag that selectize will use.
- Determine the `name` for the param name that will be send to our app server.
- Set `remote` option to `true` for smooth search UI.

#### The `submit` button
- Set `type` to `submit` (Optional if we trigger submit by javascript)

---

## wrapping common selectize configuration in a function

[gist](https://gist.github.com/mnishiguchi/af1a3c6cfed086905fbb894e3f8a708f)
