window.Questiona = {
	Models = {},
	Collections = {},
	Routers = {},
	Views = {},
	initialize : function(){
		new Questiona.Routers.Router({
			$rootEl: $('#content')
		});
		Backbone.history.start();
	}
}

$(document).ready(function(){
	Questiona.new();
});