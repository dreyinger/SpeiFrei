App.EditStudioRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('editStudio', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/studio/" + params.studio_id).done(function (data) {
			Ember.set(self.controllerFor("editStudio"), 'model', data[0]);
		});
	}
});
