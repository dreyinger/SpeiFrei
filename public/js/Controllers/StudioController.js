App.StudioController = Ember.Controller.extend({
	modelObserver: function () {
		var self = this;
		Ember.$.get('/api/v1/moviesForStudio', {studioId: Ember.get(self, 'model.StudioID')}).done(function (data) {
			Ember.set(self, 'movies', data);
		});
	}.observes('model'),
	actions: {
		deleteStudio: function () {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/deleteStudio', data).done(function(data) {
			data = JSON.parse(data);
			if (data.deleted) {
				Ember.set(self, 'deleted', 'You have deleted this Studio');
				console.log(data);
			}
			else {
				Ember.set(self, 'deleted', 'Something went wrong');
				console.log(data);
			}
			});
		},
		editStudio: function () {
			var data = Ember.get(this, 'model');
			this.transitionToRoute('/editStudio/' + data.StudioID);
		},
		goToMovie: function (id) {
			this.transitionToRoute('/movie/' + id);
		}
	}
	
});
