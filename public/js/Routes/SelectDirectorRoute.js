App.SelectDirectorRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('selectDirector', {
      into: 'main'
    });
  },
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
