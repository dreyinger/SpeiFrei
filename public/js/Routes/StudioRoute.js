App.StudioRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('studio', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/studio/" + params.studio_id).done(function (data) {
			Ember.set(self.controllerFor("studio"), 'model', data[0]);
		});
	}
});
