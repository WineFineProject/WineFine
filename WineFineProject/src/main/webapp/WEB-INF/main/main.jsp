<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
<!-- Icon Font Stylesheet -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
<!-- Libraries Stylesheet -->
<link href="../tem/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="../tem/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
<!-- Customized Bootstrap Stylesheet -->
<link href="../tem/css/bootstrap.min.css" rel="stylesheet">
<link href="../tem/css/modal.css" rel="stylesheet">
<!-- Template Stylesheet -->
<link href="../tem/css/style.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/vue@3"></script>
<script type="text/javascript" src="http://unpkg.com/axios/dist/axios.min.js"></script>
<!-- Template Javascript -->
<title>Insert title here</title>
</head>
<body>
	<tiles:insertAttribute name="header" />
	<tiles:insertAttribute name="home" />
	<div style="height: 30px;"></div>
	<tiles:insertAttribute name="footer" />
	<script src="../tem/lib/easing/easing.min.js"></script>
	<script src="../tem/lib/waypoints/waypoints.min.js"></script>
	<script src="../tem/lib/lightbox/js/lightbox.min.js"></script>
	<script src="../tem/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="../tem/js/main.js"></script>
	<script src="../tem/js/test.js"></script>
</body>
</html>