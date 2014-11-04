App.DeleteMovieController = Ember.Controller.extend({
	model: {},
	actions: {
		delete_movie: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/deleteMovie', data);
		}
	}
});