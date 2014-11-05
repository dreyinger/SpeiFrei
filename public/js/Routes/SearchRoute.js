App.SearchRoute = Ember.Route.extend ({
  renderTemplate: function () {
    this.render('main');
    this.render('search', {
      into: 'main'
    });
  }
});
