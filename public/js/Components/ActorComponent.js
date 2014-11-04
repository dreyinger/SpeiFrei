App.ActorContainerComponent = Ember.Component.extend({
	actions: {
		goToActor: function () {
			this.sendAction('action', Ember.get(this, 'model.PersID'));
		}
	}
});