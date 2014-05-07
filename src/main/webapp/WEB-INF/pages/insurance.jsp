
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

<label>
    Введите имя нажмите ENTER:<br>
    <input ng-model="query" ng-keypress="search($event)" id="query">
</label>
<span ng-show="drivers.length == 0">По запросу "{{ lastQuery }}" ничего не найдено</span>

<div class="list-group" id="searchResults">
<a href="#" class="list-group-item"
     ng-repeat="driver in drivers"
     ng-click="addToInsurance(driver)"
     ng-show="showResults" onclick="return false;">
    {{driver.name}} {{ driver.birthDate | date:"yyyy"}}
</a>
</div>

<div ng-show="current != null" class="panel panel-default" id="editForm">
    <div class="panel-heading">{{ currentOrigin.name }}</div>
    <div class="panel-body">
        <form class="form-horizontal">

            <div class="form-group">
                <label> ФИО <input ng-model="current.name"> </label>
            </div>
            <div class="form-group">
                <label> Дата рождения <input ng-model="currentBirthDate"> </label>
            </div>
            <div class="form-group">
                <label>Возраст</label> {{ current.birthDate | age }}
            </div>
            <div class="form-group">
                Пол
                <label><input type="radio" name="sex" ng-model="current.male" ng-value="true">муж.</label>
                <label><input type="radio" name="sex" ng-model="current.male" ng-value="false">жен.</label>

            </div>
            <div class="form-group">
                <label> Класс
                    <select ng-model="current.driverClass">
                        <option ng-repeat="driverClass in driverClasses">{{ driverClass }}</option>
                    </select>
                </label>
            </div>
            <div class="form-group">
                <button ng-click="save()" class="btn btn-primary">Сохранить</button>
                <button ng-click="current = null" class="btn">Закрыть</button>
            </div>
        </form>
    </div>

</div>

</body>
</html>
