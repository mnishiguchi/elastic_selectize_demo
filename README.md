# Elastic selectize demo

#### Search functionality
- Powered by [ankane/searchkick](https://github.com/ankane/searchkick)

#### Autocomplete functionality
- Powered by [selectize.js](https://selectize.github.io/selectize.js/)
- [https://github.com/selectize/selectize.js/tree/master/docs](https://github.com/selectize/selectize.js/tree/master/docs)
- [https://selectize.github.io/selectize.js/#demo-github](https://selectize.github.io/selectize.js/#demo-github)
- [https://github.com/selectize/selectize.js/blob/master/examples/github.html](https://github.com/selectize/selectize.js/blob/master/examples/github.html)

---

## Get started

```
bin/setup
```

```
rake db:seed:property          
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

Visit localhose:3000

---

## search form for selectize

```slim
= form_tag featured_properties_path, method: :get, remote: true do |f|
  .row
    .col-md-10
      input#selectize_featured_properties [name="property_container_name"]
    .col-md-2
      button.btn.btn-primary.pull-right [type="submit"]
        = fa_icon("search")
```

#### The `input` tag
- Determine the `id` for that tag that selectize will use.
- Determine the `name` for the param name that will be send to our app server.
- Set `remote` option to `true` for smooth search UI.

#### The `submit` button
- Set `type` to `submit`
