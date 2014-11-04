App.CreateMovieRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('createMovie', {
      into: 'main'
    });
  }
});
