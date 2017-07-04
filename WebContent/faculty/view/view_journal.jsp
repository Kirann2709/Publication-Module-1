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
.container {
	width: 100%;
}

li.borderless {
	border-bottom: 0 none;
	border-top: none;
}
.not-active {
   pointer-events: none;
   cursor: default;
}
ul {
	list-style: none;
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
			response.sendRedirect("../account/access_denied.jsp");
			return;
		}
		pageContext.setAttribute("principal", lao.getUsernameBySessionID(sid));
		System.out.println(pageContext.getAttribute("principal"));
		request.setAttribute("eList", list);
	%>

	<jsp:include page="../../headers/new_pages_header.jsp"></jsp:include>

	<div class="container-fluid">
<br><br><br>
		<div class="row">

			<div class="col-md-2">
				<jsp:include page="../../sidebars/view_pages_sidebar.jsp"></jsp:include>
			</div>
			<div class="col-md-10">
			<h3>View Journals</h3>
				<table class="table table-bordered">
					<thead>
						<th>PCN</th>
						<th>Name Of Authors</th>
						<th>Department</th>
						<th>Title Of Paper</th>
						<th>Journal</th>
						<th>Nationality</th>
						<th>Year</th>
						<th>Month Published</th>
						<th>Month PCN Generated</th>
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
						<th>Edit</th>
						<th>Delete</th>
					</thead>
					<c:forEach items="${eList}" var="journal">
						<c:if test="${principal == journal.writtenBy}">
							<tr>
								<td><c:if test="${empty journal.pcn}">
										<c:out value="Not Generated" />
									</c:if> 
									<c:if test="${not empty journal.pcn}">
										<c:out value="${journal.pcn}" />
									</c:if></td>
								<td><c:out value="${journal.nameOauthors}" /></td>
								<td><c:out value="${journal.deptt}" /></td>
								<td><c:out value="${journal.title}" /></td>
								<td><c:out value="${journal.journal}" /></td>
								<td><c:out value="${journal.nationality}" /></td>
								<td><c:out value="${journal.year}" /></td>
								<td><c:out value="${journal.monthPublished}" /></td>
								<td><c:out value="${journal.monthAssigned}" /></td>
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
								<c:param name="deptt" value="${journal.deptt}"></c:param>
									<c:param name="title" value="${journal.title}"></c:param>
									<c:param name="volume" value="${journal.volume}"></c:param>
									<c:param name="issue" value="${journal.issue}"></c:param>
									<c:param name="pageNo" value="${journal.pageNo}"></c:param>
								
								</c:url>
								
								<td><a href="${download}&index=0">Download</a></td>
								<td><a href="${download}&index=1">Download</a></td>
								<td><a href="${download}&index=2">Download</a></td>
								
								<c:url value="../action/action_journal.jsp" var="approve">

									<c:param name="deptt" value="${journal.deptt}"></c:param>
									<c:param name="title" value="${journal.title}"></c:param>
									<c:param name="volume" value="${journal.volume}"></c:param>
									<c:param name="issue" value="${journal.issue}"></c:param>
									<c:param name="pageNo" value="${journal.pageNo}"></c:param>
									<c:param name="level" value="1"></c:param>

								</c:url>
								<c:choose>
									<c:when test="${journal.status==0}">
										<td>Pending</td>
									</c:when>
									<c:when test="${journal.status==1}">
										<td><a>Approved by Deptt. Coordinator</a>
									</c:when>
									<c:when test="${journal.status==-1}">
										<td><a>Rejected</a></td>
									</c:when>
									<c:when test="${journal.status==2}">
										<td><a>Approved By RDIL</a></td>
									</c:when>
									<c:when test="${journal.status==-2}">
										<td><a>Rejected By RDIL</a></td>
									</c:when>
									<c:otherwise>
										<td>Invalid</td>
									</c:otherwise>
								</c:choose>
								
								<c:url value="../edit/edit_journal.jsp" var="edit">
								<c:param name="id" value="${journal.id}"></c:param>
								</c:url>
								<c:url value="../../action/delete_journal.jsp" var="delete">
								 <c:param name="id" value="${journal.id}"></c:param>
								</c:url>
								
								<c:if test="${journal.status <= 0 }">
								<td><a href='<c:out value="${edit}"/>'>Edit</a></td>
								<td><a href='<c:out value="${delete}"/>'>Delete</a></td>
								</c:if>
								<c:if test="${ journal.status > 0}">
								<td>Cannot be edited</td>
								<td>Cannot be deleted</td>
								</c:if>
								
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>

		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src=".https://getbootstrap.com/dist/js/bootstrap.min.js"></script>
</body>
</html>