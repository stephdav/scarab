<%@page session="false"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<tiles:insertDefinition name="base">
	<tiles:putAttribute name="menu">
		<span></span>
	</tiles:putAttribute>
	
	<tiles:putAttribute name="body">
      <h1>Access Denied!</h1>
	</tiles:putAttribute>
</tiles:insertDefinition>