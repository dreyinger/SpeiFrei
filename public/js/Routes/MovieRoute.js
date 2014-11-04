App.MovieRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('movie', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/movie/" + params.movie_id).done(function (data) {
			Ember.set(self.controllerFor("movie"), 'model', data[0]);
		});
	}
});
