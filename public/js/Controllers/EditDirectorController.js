App.EditDirectorController = Ember.Controller.extend({
	model: {},
	actions: {
		edit_director: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/editDirector', data);
		}
	}
});