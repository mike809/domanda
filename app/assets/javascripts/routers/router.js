Questiona.Routers.Router = Backbone.Router.extend({

	routes: {
		'/search': 'search'
	},

	inilitalize: function(){
		this.$rootEl = $rootEl;
	},

	search: function(){
		var searchFormView = new Questiona.SearchFormView.Search({ 
			model: new Questiona.Models.Search 
		});

		
	},

});
