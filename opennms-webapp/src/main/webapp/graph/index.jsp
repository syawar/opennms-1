<%--
/*******************************************************************************
 * This file is part of OpenNMS(R).
 *
 * Copyright (C) 2006-2012 The OpenNMS Group, Inc.
 * OpenNMS(R) is Copyright (C) 1999-2012 The OpenNMS Group, Inc.
 *
 * OpenNMS(R) is a registered trademark of The OpenNMS Group, Inc.
 *
 * OpenNMS(R) is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published
 * by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version.
 *
 * OpenNMS(R) is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OpenNMS(R).  If not, see:
 *      http://www.gnu.org/licenses/
 *
 * For more information contact:
 *     OpenNMS(R) Licensing <license@opennms.org>
 *     http://www.opennms.org/
 *     http://www.opennms.com/
 *******************************************************************************/

--%>

<%@page language="java"
	contentType="text/html"
	session="true"
	import="
        org.opennms.web.svclayer.ResourceService,
        org.opennms.web.servlet.XssRequestWrapper,
        org.springframework.web.context.WebApplicationContext,
      	org.springframework.web.context.support.WebApplicationContextUtils
	"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%!
    public ResourceService m_resourceService;

    public void init() throws ServletException { 
	    WebApplicationContext m_webAppContext = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
	    m_resourceService = (ResourceService) m_webAppContext.getBean("resourceService", ResourceService.class);
    }
%>

<%
    HttpServletRequest req = new XssRequestWrapper(request);
    String match = req.getParameter("match");
    pageContext.setAttribute("topLevelResources", m_resourceService.findTopLevelResources());
    pageContext.setAttribute("match", match);
%>

<jsp:include page="/includes/header.jsp" flush="false" >
  <jsp:param name="title" value="Resource Graphs" />
  <jsp:param name="headTitle" value="Resource Graphs" />
  <jsp:param name="headTitle" value="Reports" />
  <jsp:param name="location" value="performance" />
  <jsp:param name="breadcrumb" value="<a href='report/index.jsp'>Reports</a>" />
  <jsp:param name="breadcrumb" value="Resource Graphs" />
</jsp:include>


<script type="text/javascript" >
  
  function validateResource()
  {
      var isChecked = false
      for( i = 0; i < document.choose_resource.parentResourceId.length; i++ )
      {
         //make sure something is checked before proceeding
         if (document.choose_resource.parentResourceId[i].selected)
         {
            isChecked=true;
         }
      }

      if (!isChecked)
      {
          alert("Please check the resource that you would like to report on.");
      }
      return isChecked;
  }

  function validateResourceAdhoc()
  {
      var isChecked = false
      for( i = 0; i < document.choose_resource_adhoc.parentResourceId.length; i++ )
      {
         //make sure something is checked before proceeding
         if (document.choose_resource_adhoc.parentResourceId[i].selected)
         {
            isChecked=true;
         }
      }

      if (!isChecked)
      {
          alert("Please check the resource that you would like to report on.");
      }
      return isChecked;
  }

  function submitResourceForm()
  {
      if (validateResource())
      {
          document.choose_resource.submit();
      }
  }

  function submitResourceFormAdhoc()
  {
      if (validateResourceAdhoc())
      {
          document.choose_resource_adhoc.submit();
      }
  }

</script>
<div class="TwoColLeft">
  
    <h3 class="o-box">Standard Resource<br/>Performance Reports</h3>
	<div class="boxWrapper">
    <p>
      Choose a resource for a standard performance report.
    </p>
	<script type="text/javascript">
		var standardResourceData = {total:"${fn:length(topLevelResources)}", records:[
									<c:set var="first" value="true"/>
									<c:forEach var="resource" items="${topLevelResources}" varStatus="resourceCount">
									  <c:if test="${match == null || match == '' || fn:containsIgnoreCase(resource.label,match)}">
									    	<c:choose>
									    		<c:when test="${first == true}">
												<c:set var="first" value="false"/>
									    			{id:"${resource.id}", value:"${resource.resourceType.label}: ${resource.label}", type:"${resource.resourceType.label}"}
									    		</c:when>
										    	<c:otherwise>
										    		,{id:"${resource.id}", value:"${resource.resourceType.label}: ${resource.label}", type:"${resource.resourceType.label}"}
										    	</c:otherwise>
									    	</c:choose>
									    </c:if>  
									  </c:forEach>

			                                          		]};

	</script>
	<opennms:graphResourceList id="resourceList1" dataObject="standardResourceData"> </opennms:graphResourceList>
	<!-- Div for IE -->
	<div name="opennms-graphResourceList" id="resourceList-ie" dataObject="standardResourceData"></div>
  </div>
  

    <h3 class="o-box">Custom Resource<br/>Performance Reports</h3>
	<div class="boxWrapper">
    <p>
      Choose a resource for a custom performance report.
    </p>
	<script type="text/javascript">
		var customResources = {total:"${fn:length(topLevelResources)}", records:[
                                            <c:set var="first" value="true"/>
                                            <c:forEach var="resource" items="${topLevelResources}" varStatus="resourceCount">
                                              <c:if test="${match == null || match == '' || fn:containsIgnoreCase(resource.label,match)}">
                                                <c:choose>
                                                  <c:when test="${first == true}">
                                                    <c:set var="first" value="false"/>
                                                    {id:"${resource.id}", value:"${resource.resourceType.label}: ${resource.label}", type:"${resource.resourceType.label}"}
                                                  </c:when>
                                                  <c:otherwise>
                                                    ,{id:"${resource.id}", value:"${resource.resourceType.label}: ${resource.label}", type:"${resource.resourceType.label}"}
                                                  </c:otherwise>
                                                </c:choose>
                                              </c:if>  
                                            </c:forEach>

			                                                                 		]};
		
	</script>
	<opennms:graphResourceList id="resourceList2" dataObject="customResources"> </opennms:graphResourceList>
	<div name="opennms-graphResourceList" id="resourceList2-ie" dataObject="customResources"></div>
  </div>
</div>

<div class="TwoColRight">
  
    <h3 class="o-box" align=center>Network Performance Data</h3>
	<div class="boxWrapper">
    <p>
      The <strong>Standard Performance Reports</strong> provide a stock way to
      easily visualize the critical SNMP data collected from managed nodes
      and interfaces throughout your network.
    </p>

    <p>
      <strong>Custom Performance Reports</strong> can be used to produce a
      single graph that contains the data of your choice from a single
      interface or node.  You can select the timeframe, line colors, line
       styles, and title of the graph and you can bookmark the results.
    </p>
  </div>
</div>

<jsp:include page="/includes/footer.jsp" flush="false"/>
