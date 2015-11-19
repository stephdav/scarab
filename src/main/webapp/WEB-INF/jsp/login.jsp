<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="body">

      <form name='loginForm' class="form-signin" action="<c:url value='j_spring_security_check' />" method='POST'>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <h2 class="form-signin-heading">please log in</h2>
        <c:if test="${msg != null}">
			<div class="alert alert-success" role="alert">${msg}</div>
		</c:if>
        <c:if test="${error != null}">
			<div class="alert alert-danger" role="alert">${error}</div>
		</c:if>
        <label for="inputUsername" class="sr-only">username</label>
        <input type="text" id="inputUsername" name='username' class="form-control" placeholder="username" required autofocus>
        <label for="inputPassword" class="sr-only">password</label>
        <input type="password" id="inputPassword" name='password' class="form-control" placeholder="password" required>
        <button type="submit" name="submit" class="btn btn-lg btn-primary btn-block">login <span class="fa fa-sign-in"></span></button>
      </form>

	</tiles:putAttribute>
</tiles:insertDefinition>