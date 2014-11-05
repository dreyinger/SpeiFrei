App.SearchController = Ember.Controller.extend({
	tables: [
		{value: 'MOVIE', label: 'Movies'},
		{value: 'DIRECTOR', label: 'Directors'},
		{value: 'ACTOR', label: 'Actors'},
		{value: 'STUDIO', label: 'Studios'}
	],
	selectedTables: {
		MOVIE: true,
		DIRECTOR: false,
		ACTOR: false,
		STUDIO: false
	},
	selectedTable: 'MOVIE',
	selectedTableObserver: function () {
		Ember.set(this, "results", undefined);
		var selected = Ember.get(this, 'selectedTable');
		var tables = { MOVIE: false, DIRECTOR: false, ACTOR: false, STUDIO: false };
		tables[selected] = true;
		Ember.set(this, 'selectedTables', tables);
	}.observes('selectedTable'),
	querySql: function () {
		var self 		= this,
				params 	= {table: Ember.get(self, 'selectedTable'), searchText: Ember.get(self, 'searchText')};

		Ember.$.get('/api/v1/query', params).done(function (data) {
			Ember.set(self, "results", JSON.parse(data));
		});
	},
	actions: {
		search: function () {
			this.querySql();
		},
		goToStudio: function (id) {
 			if (id) {
				this.transitionToRoute('/studio/'+ id);
			}
		},
		goToDirector: function (id) {
 			if (id) {
				this.transitionToRoute('/director/'+ id);
			}
		},
		goToActor: function (id) {
 			if (id) {
				this.transitionToRoute('/actor/'+ id);
			}
		},
		goToMovie: function (id) {
 			if (id) {
				this.transitionToRoute('/movie/'+ id);
			}
		},
	}
});
