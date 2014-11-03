App.MovieRoute = Ember.Route.extend ({
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/movie/" + params.movie_id).done(function (data) {
			Ember.set(self.controllerFor("movie"), 'model', data[0]);
		});
	}
});
