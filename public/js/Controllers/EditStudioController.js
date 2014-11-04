App.EditStudioController = Ember.Controller.extend({
	model: {},
	actions: {
		submitEditStudio: function() {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/editStudio', data).done(function(data) {
			//data = JSON.parse(data);
			//if (data.edited) {
				Ember.set(self, 'edited', 'You have edited this Studio');
				console.log(data);
			//}
			//else {
			//	Ember.set(self, 'edited', 'Something went wrong');
			//	console.log(data);
			//}
			});
		}
	}
});	