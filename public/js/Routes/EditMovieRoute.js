App.EditMovieRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('editMovie', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/movie/" + params.movieID).done(function (data) {
			Ember.set(self.controllerFor("editMovie"), 'model', data[0]);
		});
	}
});
