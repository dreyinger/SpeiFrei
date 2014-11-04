App.ActorsRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('actors', {
      into: 'main'
    });
  },
	setupController: function (controller) {
    myself = controller;
    controller.set('model', []);
    this.pollForActors(controller);
  },
  pollForActors: function (controller) {
  	var self = this;
  	Ember.$.get("/api/v1/actors").done(function (data) {
  		controller.set('model', data);
  	});
  }
});
