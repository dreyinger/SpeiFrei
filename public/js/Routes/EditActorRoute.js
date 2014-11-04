App.EditActorRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('editActor', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/actor/" + params.persID).done(function (data) {
			Ember.set(self.controllerFor("editActor"), 'model', data[0]);
		});
	}
});
