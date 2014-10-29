App.ActorsRoute = Ember.Route.extend ({
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
