App.StudioContainerComponent = Ember.Component.extend({
	actions: {
		goToStudio: function () {
			this.sendAction('action', Ember.get(this, 'model.StudioID'));
		}
	}
});