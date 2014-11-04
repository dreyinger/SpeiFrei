App.EditDirectorRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('editDirector', {
      into: 'main'
    });
  },
	model: function (params) {
		var self = this;
		Ember.$.get("/api/v1/director/" + params.pers_id).done(function (data) {
			Ember.set(self.controllerFor("editDirector"), 'model', data[0]);
		});
	}
});
