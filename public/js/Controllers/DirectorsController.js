App.DirectorsController = Ember.Controller.extend({
	actions: {
		createDirector: function () {
			this.transitionToRoute('createDirector');
		},
		editDirector: function () {
			this.transitionToRoute('editDirector');
		},
		goToDirector: function (param) {
			this.transitionToRoute('/director/'+ param);
		}
	}
});
