App.UserContainerComponent = Ember.Component.extend({
	actions: {
		goToUser: function () {
			this.sendAction('action', Ember.get(this, 'model.Email'));
		}
	}
});
