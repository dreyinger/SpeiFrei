App.MoviesRoute = Ember.Route.extend ({
	setupController: function (controller) {
    myself = controller;
    controller.set('model', []);
    this.pollForMovies(controller);
  },
  pollForMovies: function (controller) {
  	var self = this;
  	Ember.$.get("/api/v1/movies").done(function (data) {
  		controller.set('model', data);
  	});
  }
});
