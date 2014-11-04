App.ActorController = Ember.Controller.extend({
		actions: {
		delete_actor: function () {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/deleteActor', data).done(function(data) {
			data = JSON.parse(data);
			if (data.deleted) {
				Ember.set(self, 'deleted', 'You have deleted this Actor');
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