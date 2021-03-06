<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Journal</title>
<link rel="stylesheet" href="../resources/styles/css/bootstrap.css">
<style>
td {
	text-align: center;
	vertical-align: middle;
	font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
	font-size: 15px;
	font-style: normal;
	font-variant: normal;
	font-weight: bold;
	line-height: 23px;
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
a{
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
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: -1;
  
  display: block;
  background-image: url('../resources/images/DSCN7348.jpg');
  
   -webkit-filter: brightness(0.8);
    filter: brightness(0.8);
  background-size:cover;
  width: 100%;
  height: 100%;
  
  -webkit-filter: blur(10px);
  -moz-filter: blur(10px);
  -o-filter: blur(10px);
  -ms-filter: blur(10px);
  filter: blur(10px);
}

.content {
  overflow:visible;
  position: relative;
}
div.transbox {
  margin: 30px;
  background-color: #ffffff;
  border: 1px solid;
  opacity: 0.6;
  filter: alpha(opacity=60); 
  width: auto;
  border-radius: 5px;
  /* For IE8 and earlier */
}


.content p {
  margin: 15px;
  background: rgba(255, 255, 255, 0.3);
  padding: 5px;
  box-shadow: 0 0 5px gray;
}
.table-borderless>tbody>tr>td, .table-borderless>tbody>tr>th,
	.table-borderless>tfoot>tr>td, .table-borderless>tfoot>tr>th,
	.table-borderless>thead>tr>td, .table-borderless>thead>tr>th {
	border: none;
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
	<jsp:include page="../headers/new_pages_header.jsp"></jsp:include>
	<jsp:useBean id="lao" class="com.publication.impl.LoginIMPL"></jsp:useBean>
	<jsp:useBean id="fao" class="com.publication.impl.FacultyIMPL"></jsp:useBean>
	<%
		String sid = (String) request.getSession(false).getAttribute("sid");
		if (null == sid) {
			response.sendRedirect("../account/access_denied.jsp");
		}
		System.out.println(sid);
	%>

	<div class="container-fluid content">
		<div class="row">
			<div class="col-md-2 transbox">
				<jsp:include page="../sidebars/new_pages_sidebar.jsp"></jsp:include></div>
			<div class="col-md-10 transbox">
<style>
h3 {
	font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
	font-size: 20px;
	font-style: normal;
	font-variant: normal;
	font-weight: bolder;
	line-height: 23px;
}</style>
				<h3>New Journal Form</h3>
<style>
.table-borderless>tbody>tr>td, .table-borderless>tbody>tr>th,
	.table-borderless>tfoot>tr>td, .table-borderless>tfoot>tr>th,
	.table-borderless>thead>tr>td, .table-borderless>thead>tr>th {
	border: none !important;
}
</style>
				<form method="POST" action="../AddPublicationService"
					enctype="multipart/form-data">
					<table class="table table-borderless">
						<tr>
							<td>Name of authors</td>
							<td><input type="text" class="form-control"
								name="nameOauthors" placeholder="Name of Authors.."></td>
						</tr>
						<tr>
							<td>Deptt.</td>
							<td><select class="form-control" name="deptt">
									<option value="cse">CSE</option>
									<option value="ece">ECE</option>
									<option value="me">ME</option>
									<option value="cvu">CVU</option>
							</select></td>
						</tr>
						<tr>
							<td>Title Of Paper</td>
							<td><input type="text" class="form-control" name="title"
								placeholder="Title goes here.."></td>
						</tr>
						<tr>
							<td>Journal</td>
							<td><input type="text" class="form-control" name="journal"
								placeholder="Journal.."></td>
						</tr>
						<tr>
							<td>International/National</td>
							<td><select name="nationality" id="nationality"
								class="form-control">
									<option value="International">International</option>
									<option value="National">National</option>
							</select></td>
						</tr>
						<tr>
							<td>Year</td>
							<td><select class="form-control" name="year">
									<%
										for (int i = Calendar.getInstance().get(Calendar.YEAR); i >= 1980; i--) {
									%>
									<option value="<%=i%>"><%=i%></option>
									<%
										}
									%>
							</select></td>
						</tr>
						<tr>
							<td>Month in which published</td>
							<td><select class="form-control" name="monthPublished">
									<%
										String[] months = new String[]{"January", "Feburary", "March", "April", "May", "June", "July", "August",
												"September", "October", "November", "December"};
										for (int i = 0; i < months.length; i++) {
									%>
									<option value="<%=months[i]%>"><%=months[i]%></option>
									<%
										}
									%>
							</select></td>
						</tr>
						<tr>
							<td>Volume</td>
							<td><input type="text" class="form-control" name="volume"
								placeholder="Volume.."></td>
						</tr>
						<tr>
							<td>Number/Issue</td>
							<td><input type="text" class="form-control" name="issue"
								placeholder="Which volume.."></td>
						</tr>
						<tr>
							<td>Page No.</td>
							<td><input type="text" class="form-control" name="pageNo"
								placeholder="Page No.."></td>
						</tr>
						<tr>
							<td>DOI No.</td>
							<td><input type="text" class="form-control" name="doiNo"
								required="on" placeholder="DOI No.."></td>
						</tr>
						<tr>
							<td>Impact Factor</td>
							<td><input type="text" class="form-control"
								name="impactFactor" placeholder="Impact Factor"></td>
						</tr>
						<tr>
							<td>Specify which impact factor</td>
							<td><input type="text" class="form-control"
								name="whatImpactFactor" placeholder="Which"></td>
						</tr>
						<tr>
							<td>Link for Impact factor</td>
							<td><input type="text" class="form-control"
								name="linkImpFactor" placeholder="Link goes here.."></td>
						</tr>
						<tr>
							<td>Paid/Unpaid</td>
							<td><select class="form-control" id="paidOrUnpaid"
								onclick="disable_unpaid()" name="paidOrUnpaid">
									<option value="Paid" selected="selected">Paid</option>
									<option value="Unpaid">Unpaid</option>
							</select></td>
						</tr>

						<tr>
							<td>Payment done or not</td>
							<td><select class="form-control" id="paymentFlag"
								name="paymentFlag">
									<option value="Yes">Yes</option>
									<option value="No">No</option>
							</select></td>
						</tr>
						<tr>
							<td>PW: Publication reported in Web of Science</td>
							<td><select class="form-control" name="pwFlag">
									<option value="Yes">Yes</option>
									<option value="No">No</option>
							</select></td>
						</tr>
						<tr>
							<td>PS: Publication reported in Scopus</td>
							<td><select class="form-control" name="psFlag">
									<option value="Yes">Yes</option>
									<option value="No">No</option>
							</select></td>
						</tr>
						<tr>
							<td>PG: Publication reported in Google Scholar</td>
							<td><select class="form-control" name="pgFlag">
									<option value="Yes">Yes</option>
									<option value="No">No</option>
							</select></td>
						</tr>
						<tr>
							<td>PI: Publication reported in Indian Citation Index</td>
							<td><select class="form-control" name="piFlag">
									<option value="Yes">Yes</option>
									<option value="No">No</option>
							</select></td>
						</tr>
						<tr>
							<td>Publication</td>
							<td><input type=file name=publication /></td>
						</tr>
						<tr>
							<td>Plag. Report</td>
							<td><input type=file name=plagReport /></td>
						</tr>
						<tr>
							<td>Plag. Copy</td>
							<td><input type=file name=plagCopy /></td>
						</tr>
						<tr>
							<input type="hidden" name="writtenBy"
								value="<%=lao.getUsernameBySessionID(sid)%>" />
							<input type="hidden" name="status" value="0">
							<input type="hidden" name="publicationType" value="J">
							
							<td>
								<button class="form-control" type="reset">Reset</button>
							</td>
							<td>
								<button class="form-control" type="submit" name="submit">Submit</button>
							</td>
						</tr>
					</table>
				</form>
			</div>

		</div>
	</div>
	
<script>
	function disable_unpaid() {
		var form = document.getElementById("paidOrUnpaid");
		var val = form.options[form.selectedIndex].value;
		if (val == "Unpaid") {
			document.getElementById("paymentFlag").value = 'No';
			document.getElementById("paymentFlag").disabled = true;
		} else if (val == "Paid") {
			document.getElementById("paymentFlag").disabled = false;
		}
	}
</script>
</body>
</html>