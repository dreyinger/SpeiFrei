App.AccountSettingsRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('accountSettings', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/accountSettings").done(function (data) {
			Ember.set(self.controllerFor("accountSettings"), 'model', data[0]);
		});
	}
});
