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
    this.putsTest(controller);
  },
  putsTest: function (controller) {
  	var self = this;
  	Ember.$.get("/api/v1/selectDirector").done(function (data) {
  		controller.set('model', data);
  	});
  }	
});
