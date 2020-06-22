<%@ page isErrorPage="true" import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="description" content="Deal or No Deal">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/bootstrap.css">

        <script src="js/jquery-2.2.4.js" type="text/javascript"></script>
        <script src="js/jquery.validate.js" type="text/javascript"></script>
        <script src="js/home.js" type="text/javascript"></script>
        <script src="js/script.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
    </head>

    <body>
        <h1>Error 404 - Page Not Found</h1>
        <p>Sorry lad, but even stealing Google's highly trained monkeys won't solve this issue</p>

        <a href="<%=request.getContextPath()%>" style="margin-top: 30px">Home</a>
    </body>
</html>