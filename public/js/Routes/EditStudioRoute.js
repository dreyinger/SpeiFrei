App.EditStudioRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('editStudio', {
      into: 'main'
    });
  }
});
