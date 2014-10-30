App.CreateMovieController = Ember.Controller.extend({
	model: {},
	actions: {
		submit_movie: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/movie', data);
		}
	}
});
