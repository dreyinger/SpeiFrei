App.CreateStudioRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('createStudio', {
      into: 'main'
    });
  }
});
