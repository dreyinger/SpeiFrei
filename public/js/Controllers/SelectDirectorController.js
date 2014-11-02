App.SelectDirectorController = Ember.Controller.extend({
	model: {},
	actions: {
		edit_Director: function () {
			var data = Ember.get(this, 'model');
			Ember.$.post('/api/v1/selectDirector', data);
		}
	}
});