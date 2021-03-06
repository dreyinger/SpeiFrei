App.EditMovieController = Ember.Controller.extend({
	model: {},
	actions: {
		submitEditMovie: function() {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/editMovie', data).done(function(data) {
			data = JSON.parse(data);
			if (data.edited) {
				Ember.set(self, 'edited', 'You have edited this Movie');
				console.log(data);
			}
			else {
				Ember.set(self, 'edited', 'Any wrong enter - Names must start with an upper case');
				console.log(data);
			}
			});
		}
	}
});	