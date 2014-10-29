App.DirectorsRoute = Ember.Route.extend ({
	setupController: function (controller) {
    myself = controller;
    controller.set('model', []);
    this.pollForDirectors(controller);
  },
  pollForDirectors: function (controller) {
  	var self = this;
  	Ember.$.get("/api/v1/directors").done(function (data) {
  		controller.set('model', data);
  	});
  }	
});
