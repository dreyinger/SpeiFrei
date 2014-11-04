App.StudiosController = Ember.Controller.extend({
	actions: {
		createStudio: function () {
			this.transitionToRoute('createStudio');
		},
		goToStudio: function (param) {
			this.transitionToRoute('/studio/' + param);
		}
	}
});
