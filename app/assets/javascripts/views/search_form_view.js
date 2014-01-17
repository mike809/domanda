Questiona.Views.SearchFormView = Backbone.View.extend({
	
	tagName: "form",
  id: "search-form",

  events: {
    "submit #search-form": "getResults"
  },
  
  getResults: function() {
    // Get values of selected options, use them to construct Ajax query. 
    // Also toggle 'selected' CSS classes on selected inputs here?
    this.model.performSearch();
  }
});
