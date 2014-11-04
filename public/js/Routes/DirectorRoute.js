App.DirectorRoute = Ember.Route.extend ({
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/director/" + params.director_id).done(function (data) {
			Ember.set(self.controllerFor("director"), 'model', data[0]);
		});
	}
});
