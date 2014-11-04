App.EditActorRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('editActor', {
      into: 'main'
    });
  }
});
