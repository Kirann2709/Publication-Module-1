<%@page import="com.publication.constants.FetchDepptCode"%>
<%@page import="com.publication.model.Journal"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
body {
	background-color: #fcfcfc;
}

td {
	text-align: center;
	vertical-align: middle;
	font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
	font-size: 15px;
	font-style: normal;
	font-variant: normal;
	font-weight: bold;
	line-height: 23px;
	color: #000;
}

th {
	text-align: center;
	vertical-align: middle;
	font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
	font-size: 17px;
	font-style: italic;
	font-variant: normal;
	font-weight: bold;
	line-height: 23px;
	color: #000;
}

h3 {
	font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
	font-size: 20px;
	font-style: normal;
	font-variant: normal;
	font-weight: bolder;
	line-height: 23px;
}

table {
	overflow: hidden;
	text-overflow: ellipsis;
	word-wrap: break-word;
}

a {
	font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
	font-size: 17px;
	font-style: normal;
	font-variant: normal;
	font-weight: bold;
	line-height: 23px;
}

.container {
	width: 100%;
}

li.borderless {
	border-bottom: 0 none;
	border-top: none;
}

ul {
	list-style: none;
}

.content:before {
	content: "";
	position: fixed;
	padding: 10px;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: -1;
	display: block;
	background-image: url('../../resources/images/DSCN7348.jpg');
	-webkit-filter: brightness(0.8);
	filter: brightness(0.8);
	background-size: cover;
	width: 100%;
	height: 100%;
	-webkit-filter: blur(05px);
	-moz-filter: blur(05px);
	-o-filter: blur(05px);
	-ms-filter: blur(05px);
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: -1;
	display: block;
	background-image: url('../../resources/images/DSCN7348.jpg');
	-webkit-filter: brightness(0.8);
	filter: brightness(0.8);
	background-size: cover;
	width: 100%;
	height: 100%;
	-webkit-filter: blur(05px);
	-moz-filter: blur(05px);
	-o-filter: blur(05px);
	-ms-filter: blur(05px);
	filter: blur(05px);
}

.content {
	overflow: visible;
	position: relative;
}

div.transbox {
	margin: 30px;
	background-color: rgba(255, 255, 255, 0.6);
	border: 0px solid;
	padding: 20px;
	border-radius: 5px;
	width: auto;

	/* For IE8 and earlier */
}

.content p {
	margin: 15px;
	background: rgba(255, 255, 255, 0.3);
	padding: 5px;
	box-shadow: 0 0 5px gray;
}
</style>

</head>
<input type="hidden" id="refreshed" value="no">
<script type="text/javascript">
	onload = function() {
		var e = document.getElementById("refreshed");
		if (e.value == "no")
			e.value = "yes";
		else {
			e.value = "no";
			location.reload();
		}
	}
</script>
<body>
	<jsp:useBean id="dao" class="com.publication.impl.JournalIMPL"
		scope="page"></jsp:useBean>
	<jsp:useBean id="lao" class="com.publication.impl.LoginIMPL"
		scope="page"></jsp:useBean>
	<%
		List<Journal> list = dao.getAllJournals();
		for (Journal j : list) {
			System.out.println(j);
		}
		String sid = (String) request.getSession(false).getAttribute("sid");
		if (null == sid) {
			response.sendRedirect("../../account/access_denied.jsp");
			return;
		}
		if (!lao.getRoleBySessionID(sid).contains("ROLE_DC")) {
			response.sendRedirect("../../account/access_denied.jsp");
			return;
		}
		pageContext.setAttribute("sorter", FetchDepptCode.getDepttCode(lao.getRoleBySessionID(sid)));
		request.setAttribute("eList", list);
	%>
	<jsp:include page="../../headers/new_pages_header.jsp"></jsp:include>

	<br>
	<br>
	<br>
	<div class="container-fluid content">
		<div class="row">


			<div class="col-md-12 transbox">
				<h3>Journals</h3>
				<div>
					<c:if test="${not empty param.approve}">
						<p>
							<c:if test="${param.approve == 'success'}">
								<c:out value="Approving Record Successful"></c:out>
							</c:if>
							<c:if test="${param.approve == 'failed'}">
								<c:out value="Approving Record Unsuccessful"></c:out>
							</c:if>
						</p>
					</c:if>
					<c:if test="${not empty param.reject}">
						<p>
							<c:if test="${param.reject == 'success'}">
								<c:out value="Rejecting Record Successful"></c:out>
							</c:if>
							<c:if test="${param.reject == 'failed'}">
								<c:out value="Rejecting Record Unsuccessful"></c:out>
							</c:if>
						</p>
					</c:if>
				</div>
				<br>
				<div style="width: 400px;">
					<input type="text" class="form-control" id="search"
						placeholder="Type to search">
				</div>
				<table id="table" class="table table-condensed table-bordered" >
					<thead>
						<th>PCN</th>
						<th>Name Of Authors</th>
						<th>Department</th>
						<th>Title Of Paper</th>
						<th>Journal</th>
						<th>Nationality</th>
						<th>Year</th>
						<th>Month Published</th>
						<th>Volume</th>
						<th>Number/Issue</th>
						<th>Page No</th>
						<th>DOI No.</th>
						<th>Impact Factor</th>
						<th>What Impact Factor</th>
						<th>Link for Impact factor</th>
						<th>Paid/Unpaid</th>
						<th>Payment Done or not</th>
						<th>PW : Publication reported in Web of Science)</th>
						<th>PS: Publication reported in Scopus</th>
						<th>PG: Publication reported in Google Scholar</th>
						<th>PI: Publication reported in Indian Citation Index</th>
						<th>Resource</th>
						<th>Plag. Report</th>
						<th>Plag. Copy</th>
						<th>Status</th>
					</thead>
					<c:forEach items="${eList}" var="journal">
						<c:if test="${sorter == journal.deptt}">

							<tr>

								<td><c:if test="${empty journal.pcn}">
										<c:out value="Not Generated" />
									</c:if> <c:if test="${not empty journal.pcn}">
										<c:out value="${journal.pcn}" />
										<br>
										<br>
										<c:out value="${journal.monthAssigned}" />
									</c:if></td>
								<td><c:out value="${journal.nameOauthors}" /></td>
								<td><c:out value="${journal.deptt}" /></td>
								<td><c:out value="${journal.title}" /></td>
								<td><c:out value="${journal.journal}" /></td>
								<td><c:out value="${journal.nationality}" /></td>
								<td><c:out value="${journal.year}" /></td>
								<td><c:out value="${journal.monthPublished}" /></td>
								<td><c:out value="${journal.volume}" /></td>
								<td><c:out value="${journal.issue}" /></td>
								<td><c:out value="${journal.pageNo}" /></td>
								<td><c:out value="${journal.doiNo}" /></td>
								<td><c:out value="${journal.impactFactor}" /></td>
								<td><c:out value="${journal.whatImpactFactor}" /></td>
								<td><c:out value="${journal.linkImpFactor}" /></td>
								<td><c:out value="${journal.paidOrUnpaid}" /></td>
								<td><c:out value="${journal.paymentFlag}" /></td>
								<td><c:out value="${journal.pwFlag}" /></td>
								<td><c:out value="${journal.psFlag}" /></td>
								<td><c:out value="${journal.pgFlag}" /></td>
								<td><c:out value="${journal.piFlag}" /></td>
								<c:url value="../../DownloadResource" var="download">
									<c:param name="id" value="${cp.id}"></c:param>
									<c:param name="type" value="J"></c:param>
								</c:url>

								<td><a href="${download}&index=0" class="btn btn-info">
										<span class="glyphicon glyphicon-download"></span>
								</a></td>
								<td><a href="${download}&index=1" class="btn btn-info">
										<span class="glyphicon glyphicon-download"></span>
								</a></td>
								<td><a href="${download}&index=2" class="btn btn-info">
										<span class="glyphicon glyphicon-download"></span>
								</a></td>


								<c:url value="../../action/approve.jsp" var="action">
									<c:param name="id" value="${journal.id}" />
									<c:param name="level" value="1"></c:param>
									<c:param name="type" value="J"></c:param>
								</c:url>
								<c:url value="../../action/reject.jsp" var="reject">
								</c:url>

								<c:choose>
									<c:when test="${journal.status==0}">
										<td><a class="btn btn-info disabled">Pending</a> <br>
											<a href="${action}&status=1" class="btn btn-success">Approve</a>
											<!-- Reject Button -->
											<button type="button" class="btn btn-danger"
												style="width: 90px;" data-name="${journal.id}"
												data-toggle="modal" data-target="#myModal"
												onclick="setModalValue(this)">Reject</button> <!-- Reject Modal -->
											<div class="modal fade" id="myModal" role="dialog">
												<div class="modal-dialog">

													<!-- Modal content-->
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal">&times;</button>
															<h4 class="modal-title">Reason to Reject</h4>
														</div>
														<div class="modal-body">
															<form action="${reject}" method="get">
																<input type="text" class="form-control" name="reason">
																<input type="hidden" class="form-control" name="id"
																	id="reject_id"> <input type="hidden"
																	class="form-control" name="level" value="1"> <input
																	type="hidden" class="form-control" name="status"
																	value="-1"> <input type="hidden"
																	class="form-control" name="type" value="J">
																<button type="submit" class="btn btn-default"
																	name="Submit">Submit</button>
															</form>

														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default"
																data-dismiss="modal">Close</button>
														</div>
													</div>

												</div>
											</div></td>

									</c:when>
									<c:when test="${journal.status==1}">
										<td><a class="btn btn-info disabled">Approved by
												Deptt. Coordinator</td>
									</c:when>
									<c:when test="${journal.status==-1}">
										<td><a class="btn btn-info disabled">Rejected</a></td>
									</c:when>
									<c:when test="${journal.status==2}">
										<td><a class="btn btn-info disabled"> Approved By
												RDIL</a></td>
									</c:when>
									<c:when test="${journal.status==-2}">
										<td><a class="btn btn-info disabled">Rejected By RDIL</a></td>
									</c:when>
									<c:otherwise>
										<td>Invalid</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>

		</div>
	</div>
	
		<script type="text/javascript">
		var $rows = $('#table tr');
		$('#search').keyup(function() {
			var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

			$rows.show().filter(function() {
				var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
				return !~text.indexOf(val);
			}).hide();
		});
	</script>
	<script type="text/javascript">
		function setModalValue(button) {
			var att = button.getAttribute("data-name");
			document.getElementById('reject_id').value = att;
		}
	</script>

</body>
</html>