App.MovieController = Ember.Controller.extend({
	modelObserver: function () {
		var self = this;
		var studioId = self.get('model.StudioID');
		var movieId = self.get('model.D_PersID');
		if (studioId) {
			Ember.$.get('/api/v1/studio/' + studioId).done(function (data) {
				Ember.set(self, "studioName", data[0].Name);
			});
		} else {
			Ember.set(self, "studioName", "unknown");
		}
		if (movieId) {
			Ember.$.get('/api/v1/movie/' + movieId).done(function (data) {
				var movieName = data[0].Firstname + " " + data[0].Surname;
				Ember.set(self, "movieName", movieName);
			});
		} else {
			Ember.set(self, "movieName", "unknown");
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
				console.log(data);
			}
			else {
				Ember.set(self, 'deleted', 'Something went wrong');
				console.log(data);
			}
			});
		},
		editMovie: function () {
			var data = Ember.get(this, 'model');
			this.transitionToRoute('/editMovie/' + data.MovieID);
		}
	}
});
