App.StudioController = Ember.Controller.extend({
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
		}
	}
	
});
