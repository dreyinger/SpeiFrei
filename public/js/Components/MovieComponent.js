App.MovieContainerComponent = Ember.Component.extend({
	studioName: function(data) {
		//console.log("test", data);
		var self = this; 
		console.log(Ember.$.get('/api/v1/studio/1000').done(function (data) {return data[0].Name}));
	}.property('model.StudioID')
	
});