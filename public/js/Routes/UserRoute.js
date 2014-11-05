App.UserRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('user', {
      into: 'main'
    });
  },
	model: function (params) {
		console.log(params)
		var self = this;
		Ember.$.get("/api/v1/user/" + params.email).done(function (data) {
			console.log(data);
			Ember.set(self.controllerFor("user"), 'model', JSON.parse(data)[0]);
		});
	}
});