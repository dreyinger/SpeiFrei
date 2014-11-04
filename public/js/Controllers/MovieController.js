App.MovieController = Ember.Controller.extend({
	modelObserver: function () {
		var self = this;
		var studioId = self.get('model.StudioID');
		var directorId = self.get('model.D_PersID');
		if (studioId) {
			Ember.$.get('/api/v1/studio/' + studioId).done(function (data) {
				Ember.set(self, "studioName", data[0].Name);
			});
		} else {
			Ember.set(self, "studioName", "unknown");
		}
		if (directorId) {
			Ember.$.get('/api/v1/director/' + directorId).done(function (data) {
				var directorName = data[0].Firstname + " " + data[0].Surname;
				Ember.set(self, "directorName", directorName);
			});
		} else {
			Ember.set(self, "directorName", "unknown");
		}
	}.observes('model'),
	actions: {
		delete_movie: function () {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/deleteMovie', data).done(function(data) {
				data = JSON.parse(data);
				if (data.deleted) {
					Ember.set(self, 'deleted', 'You have deleted this Movie');
				}
				else {
					Ember.set(self, 'deleted', 'Something went wrong');
				}
			});
		
		}
	}
});
