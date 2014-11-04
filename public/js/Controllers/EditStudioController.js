App.EditStudioController = Ember.Controller.extend({
	model: {},
	actions: {
		submitEditStudio: function() {
			var self = this;
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/editStudio', data).done(function(data) {
			if (data.edited) {
				Ember.set(self, 'edited', 'You have edited this Studio');
				console.log(data);
			}
			else {
				Ember.set(self, 'edited', 'Any wrong enter - Name and Headquater must start with an upper case');
				console.log(data);
			}
			});
		}
	}
});	