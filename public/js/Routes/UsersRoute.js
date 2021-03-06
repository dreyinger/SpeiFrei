App.UsersRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('users', {
      into: 'main'
    });
  },
	setupController: function (controller) {
    myself = controller;
    controller.set('model', []);
    this.pollForUsers(controller);
  },
  pollForUsers: function (controller) {
  	var self = this;
  	Ember.$.get("/api/v1/users").done(function (data) {
  		controller.set('model', JSON.parse(data));
  	});
  }
});