App.StudioRoute = Ember.Route.extend ({
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/studio/" + params.studio_id).done(function (data) {
			Ember.set(self.controllerFor("Studio"), 'model', data[0]);
		});
	}
});
