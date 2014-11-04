App.StudiosRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('studios', {
      into: 'main'
    });
  },
	setupController: function (controller) {
    myself = controller;
    controller.set('model', []);
    this.pollForStudios(controller);
  },
  pollForStudios: function (controller) {
  	var self = this;
  	Ember.$.get("/api/v1/studios").done(function (data) {
  		controller.set('model', data);
  	});
  }
});
