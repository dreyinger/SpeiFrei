App.SearchController = Ember.Controller.extend({
	tables: [
		{value: 'Movies', label: 'Movies'},
		{value: 'Users', label: 'Users'},
		{value: 'Directors', label: 'Directors'},
		{value: 'Actors', label: 'Actors'},
		{value: 'Studios', label: 'Studios'}
	],
	selectedTable: 'Movies',
	sql: function (param) {
		console.log(param);
		return "testing"
	}.property('selectedTable', 'searchText'),
	actions: {
		search: function () {
			console.log("searching");
		}
	}
});
