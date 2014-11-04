App.DirectorRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('director', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/director/" + params.persID).done(function (data) {
			Ember.set(self.controllerFor("director"), 'model', data[0]);
		});
	}
});