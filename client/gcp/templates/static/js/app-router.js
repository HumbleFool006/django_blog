app.config(["$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider){
	$urlRouterProvider.otherwise("/");
	$stateProvider.state("login", {
		url:"/",
		templateUrl:"static/templates/login.html",
		controller:"loginCtrl"
	});

	$stateProvider.state("signup",{
		url:"/signup",
		templateUrl:"static/templates/signup.html",
		controller:"signupCtrl"
	});

	$stateProvider.state('about', {
		url:"/about",
		template:"<h1>Create by giri</h1>"
	});

	$stateProvider.state('review', {
		url:'/review',
		controller:'reviewCtrl',
		templateUrl:"static/templates/review.html"
	});
	$stateProvider.state('list_reviews', {
		url:'/list_review',
		controller:'reviewListCtrl',
		templateUrl:"static/templates/list_reviews.html"
	})
}])
