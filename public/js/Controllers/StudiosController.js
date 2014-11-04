App.StudiosController = Ember.Controller.extend({
	actions: {
		createStudio: function () {
			this.transitionToRoute('createStudio');
		},
		editStudio: function () {
			this.transitionToRoute('editStudio');
		},
		goToStudio: function (param) {
			this.transitionToRoute('/studio/' + param);
		}
	}
});
