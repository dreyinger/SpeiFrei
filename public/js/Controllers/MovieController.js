App.MovieController = Ember.Controller.extend({
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
			
		}
	}
	
});