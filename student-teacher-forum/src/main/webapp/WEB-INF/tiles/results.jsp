<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="pgn"%>
<c:set var="searchUrl" value="/search?s=${s}" />

<div class="row">
	<div class="search-option">
		<strong>Search &quot;${s}&quot; By:</strong> <span
			style="display: inline-block; width: YOURWIDTH;"></span>

		<button type="button" class="btn btn-primary" id="firstname"
			onclick="location.href='/search?s=${s}'">First Name</button>

		<button type="button" class="btn btn-primary" id = "surname"
			onclick="location.href='/search-surname?s=${s}'">Surname</button>

		<button type="button" class="btn btn-primary" id = "interest"
			onclick="location.href='/search-interest?s=${s}'">Interest</button>
	</div>
	<div class="col-md-12 results-noresult">
		<c:if test="${empty page.content}"> 
    		No Results 
		</c:if>
	</div>
	<div class="row">
		<div class="col-md-12">
			<pgn:pagination url="${searchUrl}" page="${page}" size="10" />
		</div>
	</div>

	<c:forEach var="result" items="${page.content}">
		<c:url var="profilePhoto" value="/profile-photo/${result.userId}" />
		<c:url var="profileLink" value="/profile/${result.userId}" />

		<div class="list-group">
			<div class="list-group-item clearfix">
				<div class="profile-teaser-left">
					<div class="profile-img">
						<a href="${profileLink}"><img src="${profilePhoto}" /></a>
					</div>
				</div>
				<div class="profile-teaser-main">
					<h2 class="profile-name">
						<a href="${profileLink}"><c:out value="${result.firstname}" />
							<c:out value="${result.surname}" /></a>
					</h2>
					<div class="profile-info">
						<div class="info">
							Interests:
							<c:forEach var="interest" items="${result.interests}"
								varStatus="status">
								<c:url var="interestLink" value="/search?s=${interest.name}" />

								<a href="${interestLink}"><c:out value="${interest.name}" /></a>

								<c:if test="${!status.last}">|</c:if>
							</c:forEach>
						</div>
						<br>
						<div class="info">
							Personal Statement: <span>
								<ul>${result.about}
								</ul>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<script>

	$(document).ready(function() {
		if("${type}"=="firstname"){
			$("#firstname").removeClass("btn btn-primary").addClass("btn btn-secondary");
		}
		if("${type}"=="surname"){
			$("#surname").removeClass("btn btn-primary").addClass("btn btn-secondary");
		}
		if("${type}"=="interest"){
			$("#interest").removeClass("btn btn-primary").addClass("btn btn-secondary");
		}
		
	});
</script>