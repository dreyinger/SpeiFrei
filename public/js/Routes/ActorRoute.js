App.ActorRoute = Ember.Route.extend ({
	renderTemplate: function () {
    this.render('main');
    this.render('actor', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/actor/" + params.persID).done(function (data) {
			Ember.set(self.controllerFor("actor"), 'model', data[0]);
		});
	}
});