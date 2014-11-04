App.DeleteMovieRoute = Ember.Route.extend ({
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/deleteMovie/" + params.movie_id);
		});
	}
});
