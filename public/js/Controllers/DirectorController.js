App.DirectorController = Ember.Controller.extend({
	modelObserver: function () {
		var self = this;
		Ember.$.get('/api/v1/moviesForDirector', {directorId: Ember.get(self, 'model.PersID')}).done(function (data) {
			Ember.set(self, 'movies', data);
		});
	}.observes('model'),
	actions: {
		delete_director: function () {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/deleteDirector', data).done(function(data) {
			data = JSON.parse(data);
			if (data.deleted) {
				Ember.set(self, 'deleted', 'You have deleted this Director');
				console.log(data);
			}
			else {
				Ember.set(self, 'deleted', 'Something went wrong');
				console.log(data);
			}
			});
		},
		goToMovie: function (id) {
			this.transitionToRoute('/movie/' + id);
		},
		editDirector: function () {
			var data = Ember.get(this, 'model');
			this.transitionToRoute('/editDirector/' + data.PersID);
		}
	}
	
});
