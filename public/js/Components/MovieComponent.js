App.MovieContainerComponent = Ember.Component.extend({
	// willInsertElement: function() {
	// 	var self = this;
	// 	var studioId = self.get('model').StudioID;
	// 	var directorId = self.get('model').D_PersID;
	// 	// if (studioId) {
	// 	// 	Ember.$.get('/api/v1/studio/' + studioId).done(function (data) {
	// 	// 		Ember.set(self, "studioName", data[0].Name);
	// 	// 	});
	// 	// } else {
	// 	// 	Ember.set(self, "studioName", "unknown");
	// 	// }
	// 	// if (directorId) {
	// 	// 	Ember.$.get('/api/v1/director/' + directorId).done(function (data) {
	// 	// 		// Ember.set(self, "directorName", data.Name);
	// 	// 	});
	// 	// } else {
	// 	// 	Ember.set(self, "directorName", "unknown");
	// 	// }
	// }
	actions: {
		goToMovie: function () {
			this.sendAction('action', Ember.get(this, 'model.MovieID'));
		}
	}
});