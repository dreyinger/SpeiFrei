App.MainController = Ember.Controller.extend({
	auth: getCookie("auth"),
	init: function () {
		if (!getCookie("auth")) {
			this.transitionToRoute('signin');
		};
	},
	showDrop: false,
	actions :   {
		home: function () {
			this.transitionToRoute('movies');
		},
		studios: function () {
			this.transitionToRoute('studios');
		},
		actors: function () {
			this.transitionToRoute('actors');
		},
		directors: function () {
			this.transitionToRoute('directors');
		},
		createDirector: function () {
			this.transitionToRoute('createDirector');
		},
		editDirector: function () {
			this.transitionToRoute('editDirector');
		},
		selectDirector: function () {
			this.transitionToRoute('selectDirector');
		},
		createActor: function () {
			this.transitionToRoute('createActor');
		},
		editActor: function () {
			this.transitionToRoute('editActor');
		},
		createStudio: function () {
			this.transitionToRoute('createStudio');
		},
		account: function () {
			this.toggleProperty('showDrop');
		},
		logout: function () {
			this.toggleProperty('showDrop');
			delCookie('auth');
			this.transitionToRoute('signin');
		},
		accountSettings: function () {
			this.toggleProperty('showDrop');
			this.transitionToRoute('accountSettings');
		}
	}
});
