App.CreateActorRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('createActor', {
      into: 'main'
    });
  }
});
