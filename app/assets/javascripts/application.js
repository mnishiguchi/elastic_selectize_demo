//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require selectize

// A container for namespacing our js code.
window.app = window.app || {};

// Expose our browerified modules.
window.app.selectizeGithubSearch       = require('app/selectize_github_search');
window.app.selectizeFeaturedProperties = require('app/selectize_featured_properties');
