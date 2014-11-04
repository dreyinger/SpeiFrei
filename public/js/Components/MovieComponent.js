App.MovieContainerComponent = Ember.Component.extend({
	actions: {
		goToMovie: function () {
			this.sendAction('action', Ember.get(this, 'model.MovieID'));
		}
	}
});