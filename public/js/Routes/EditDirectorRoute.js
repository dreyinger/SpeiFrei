App.EditDirectorRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('editDirector', {
      into: 'main'
    });
  },
	setupController: function (controller) {
    myself = controller;
    controller.set('model', []);
  }

});
