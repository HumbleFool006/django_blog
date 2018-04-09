app.controller("SignUpCtrl", ['$scope', '$http', function(scope, http){
	scope.formData = {};
	scope.firstname = "arun";
	scope.formData = scope.form;
	scope.postData=function(){
		console.log("omoomnmo")
				console.log(scope.form),

	http({
		url:'http://127.0.0.1:8000/api/auth/signup/',
		method:'POST',
		data: "username=viewlogs",
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        }).success(function (data, status, headers, config) {
                scope.persons = data; // assign  $scope.persons here as promise is resolved here 
            }).error(function (data, status, headers, config) {
                scope.status = status;
            });
        }
	}]);

app.controller('reviewCtrl', ['$scope', '$http', '$httpParamSerializer', function(sc, http, ser){
	sc.postData=function(){
		console.log(ser(sc.form));
	http({
		url:'/api/review/post/',
		method:'POST',
		data:ser(sc.form),
		headers:{'Content-Type': 'application/x-www-form-urlencoded'}
	}).success(function(data, status, headers, config){
		sc.resp = data;
	}).error(function(data, status, headers, config){
		sc.resp = status;
		});
	}
	}]);

app.controller('reviewListCtrl', ['$scope', '$http', '$httpParamSerializer', function(sc, http, ser){
	sc.getData=function(){
	http({
		url:'/api/review/list/',
		method:'GET',
	}).success(function(data, status, headers, config){
		sc.resp = data;
	}).error(function(data, status, headers, config){
		sc.resp = status;
	}
	)
	}
	sc.getData();
	}]);