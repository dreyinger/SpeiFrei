App.CreateDirectorRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('createDirector', {
      into: 'main'
    });
  }
});
