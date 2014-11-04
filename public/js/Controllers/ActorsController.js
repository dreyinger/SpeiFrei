App.ActorsController = Ember.Controller.extend({
	actions: {
		createActor: function () {
			this.transitionToRoute('createActor');
		},
		editActor: function () {
			this.transitionToRoute('editActor');
		}
	}
});
