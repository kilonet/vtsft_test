
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html ng-app="ngInsurance">
<head>
    <title>Страховка</title>
    <script src="<c:url value="/static/js/angular.js" />"></script>
    <script src="<c:url value="/static/js/app.js" />"></script>
    <link rel="stylesheet" href="<c:url value="/static/css/style.css" />">
    <link rel="stylesheet" href="<c:url value="/static/css/bootstrap.min.css" />">
    <script type="text/javascript">
        var CONTEXT_ROOT = '<%= request.getContextPath() %>';
    </script>
</head>
<body ng-controller="DriversCtrl" ng-click="showResults = false">

<h1>Страховка</h1>
<p ng-show="insurance.length == 0">Страховка пуста. Добавьте водителей:</p>
<table class="table" id="insurance" ng-hide="insurance.length == 0">
    <tr>
        <th>ФИО</th>
        <th>Дата рождения</th>
        <th>Возраст</th>
        <th>Пол</th>
        <th>Класс</th>
        <th></th>
        <th><th>
    </tr>
    <tr ng-repeat="driver in insurance track by driver.id">
        <td>{{ driver.name }}</td>
        <td>{{ driver.birthDate | date:"shortDate" }}</td>
        <td>{{ driver.birthDate | age }}</td>
        <td>{{ driver.male ? "муж" : "жен"}}</td>
        <td>{{ driver.driverClass }}</td>
        <th><button ng-click="edit(driver)" class="btn">Редактировать</button></th>
        <th><button ng-click="remove(driver)" class="btn btn-danger">Удалить</button></th>
    </tr>
</table>

<form role="form">
    <div class="form-group">
        <label for="query">Введите имя и нажмите ENTER:</label>
        <input ng-model="query" ng-keypress="search($event)" id="query" class="form-control">
    </div>
</form>

<span ng-show="drivers.length == 0">По запросу "{{ lastQuery }}" ничего не найдено</span>

<div class="list-group" id="searchResults">
<a href="#" class="list-group-item"
     ng-repeat="driver in drivers"
     ng-click="addToInsurance(driver)"
     ng-show="showResults" onclick="return false;">
    {{driver.name}} {{ driver.birthDate | date:"yyyy"}}
</a>
</div>

<div ng-hide="current == null" class="panel panel-default" id="editForm">
    <div class="panel-heading">{{ currentOrigin.name }}</div>
    <div class="panel-body">

        <form class="form-horizontal" role="form">

            <div class="form-group">
                <label for="name" class="col-sm-3 control-label">ФИО</label>
                <div class="col-sm-9">
                    <input class="form-control" id="name" placeholder="ФИО" ng-model="current.name">
                </div>
            </div>

            <div class="form-group">
                <label for="date" class="col-sm-3 control-label">Дата рождения</label>
                <div class="col-sm-9">
                    <input class="form-control" id="date" placeholder="Дата рождения" ng-model="currentBirthDate">
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Возраст</label>
                <div class="col-sm-9">
                    <p class="form-control-static">{{ current.birthDate | age }}</p>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">Пол</label>
                <div class="col-sm-9">
                    <label class="radio-inline"><input id="male" type="radio" name="sex" ng-model="current.male" ng-value="true">муж.</label>
                    <label class="radio-inline"><input id="female" type="radio" name="sex" ng-model="current.male" ng-value="false">жен.</label>
                </div>
            </div>

            <div class="form-group">
                <label for="driverClass" class="col-sm-3 control-label">Класс</label>
                <div class="col-sm-2">
                    <select ng-model="current.driverClass" id="driverClass" class="form-control">
                        <option ng-repeat="driverClass in driverClasses">{{ driverClass }}</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <button ng-click="save()" class="btn btn-primary">Сохранить</button>
                    <button ng-click="current = null" class="btn">Закрыть</button>
                </div>
            </div>


        </form>


    </div>

</div>

</body>
</html>
