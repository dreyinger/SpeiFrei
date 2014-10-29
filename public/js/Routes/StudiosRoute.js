App.StudiosRoute = Ember.Route.extend ({
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
