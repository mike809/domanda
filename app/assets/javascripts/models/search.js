Questiona.Models.Search = Backbone.Model.extend({

	initialize: function(){
		this.performSearch($('#search-box').val())
	},

	performSearch: function(str) {
    // fire the ajax request.  provide a bound
    // _searchComplete as the callback
  },
 
  _searchComplete: function(results) {
    this.set("searchResults", results);
  }

});

  

  // var SearchResultsView = Backbone.View.extend({
  //   tagName: "ul",
  //   id: "results-list",
  //   initialize: function() {
  //       this.model.on("change:searchResults", this.displayResults, this);
  //   },
  //   displayResults: function(model, results) {
  //     //append results to results-list here.   
  //     //update contents of blurb here?
  //   }
  // });
  // var searchModel = new SearchModel();
  // var searchFormView = new SearchFormView({ model: searchModel });
  // var searchResultsView = new SearchResultsView({ model: searchModel });