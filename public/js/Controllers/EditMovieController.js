App.EditMovieController = Ember.Controller.extend({
		actions: {
		edit_movie: function () {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/editMovie', data).done(function(data) {
			data = JSON.parse(data);
			if (data.editd) {
				Ember.set(self, 'editd', 'You have editd this Movie');
				console.log(data);
			}
			else {
				Ember.set(self, 'editd', 'Something went wrong');
				console.log(data);
			}
			});
			
		}
	}
	
});