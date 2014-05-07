var ngInsurance = angular.module("ngInsurance", []);

ngInsurance.controller("DriversCtrl", function($scope, $http, $filter) {

    $scope.insurance = [];
    $scope.current = null;
    var result = $http.get(CONTEXT_ROOT + "/driverClasses");
    result.success(function(data) {
        $scope.driverClasses = data;
    });

    $scope.search = function($event) {
        if ($event.keyCode != 13 || $scope.query.length == 0) return;
        $scope.lastQuery = $scope.query;
        var result = $http.get(CONTEXT_ROOT + "/drivers/?query=" + encodeURIComponent($scope.query));
        result.success(function(data) {
            $scope.drivers = data;
            $scope.showResults = true; // todo
        })
    };

    $scope.addToInsurance = function(driver) {

        for(var i = 0; i < $scope.insurance.length; i++) {
            if ($scope.insurance[i].id == driver.id) {
                alert("Водитель \"" + driver.name + "\" уже добавлен");
                return;
            }
        }

        $scope.insurance.push(driver);
        $scope.query = driver.name;
        $scope.showResults = false;
    };

    $scope.remove = function(driver) {
        if (confirm("Удалить водителя \"" + driver.name + "\"?")) {
            $scope.insurance.splice($scope.insurance.indexOf(driver), 1)
        }
    };

    $scope.edit = function(driver) {
        $scope.current = angular.copy(driver);
        $scope.currentOrigin = driver;
        $scope.currentBirthDate = $filter("date")(driver.birthDate, "dd.MM.yyyy")
    };

    $scope.$watch("currentBirthDate", function(newValue) {
        if (typeof(newValue) == 'undefined' || newValue.length == 0) return;
        var date = newValue.split(".");
        $scope.current.birthDate = new Date(date[2], date[1]-1, date[0]);
    });

    $scope.save = function() {
        var result = $http.post(CONTEXT_ROOT + "/driverSave", $scope.current);
        result.success(function(data) {
            // update in insurance
            $scope.insurance[$scope.insurance.indexOf($scope.currentOrigin)] = $scope.current;

            $scope.current = null;
        })
    };

});

ngInsurance.filter("age", function() {
    return function(birthDate) {
        // заменить на более точный при необходимости
        var ageDifMs = Date.now() - birthDate;
        var ageDate = new Date(ageDifMs);
        return Math.abs(ageDate.getUTCFullYear() - 1970);
    }
});

