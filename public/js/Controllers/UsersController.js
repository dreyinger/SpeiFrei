App.UsersController = Ember.Controller.extend({
	actions: {
		goToUser: function (param) {
			console.log(param);
			this.transitionToRoute('/user/' + param);
		}
	}
});
