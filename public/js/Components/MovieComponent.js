App.MovieContainerComponent = Ember.Component.extend({
	willInsertElement: function() {
		var self = this;
		var studioId = self.get('model').StudioID;
		if (studioId) {
			Ember.$.get('/api/v1/studio/1000').done(function (data) {
				Ember.set(self, "studioName", data[0].Name)
			});
		} else {
			Ember.set(self, "studioName", "unknown");
		}
	}
	
});