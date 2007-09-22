<%--

//
// This file is part of the OpenNMS(R) Application.
//
// OpenNMS(R) is Copyright (C) 2002-2003 The OpenNMS Group, Inc.  All rights reserved.
// OpenNMS(R) is a derivative work, containing both original code, included code and modified
// code that was published under the GNU General Public License. Copyrights for modified 
// and included code are below.
//
// OpenNMS(R) is a registered trademark of The OpenNMS Group, Inc.
//
// Original code base Copyright (C) 1999-2001 Oculan Corp.  All rights reserved.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
//
// For more information contact:
//      OpenNMS Licensing       <license@opennms.org>
//      http://www.opennms.org/
//      http://www.opennms.com/
//

--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/includes/header.jsp" flush="false">
	<jsp:param name="title" value="Threshold Editor" />
	<jsp:param name="headTitle" value="Edit Threshold" />
	<jsp:param name="headTitle" value="Thresholds" />
	<jsp:param name="headTitle" value="Admin" />
	<jsp:param name="breadcrumb" value="<a href='admin/index.jsp'>Admin</a>" />
    <jsp:param name="breadcrumb" value="<a href='admin/thresholds/index.jsp'>Threshold Groups</a>" />
    <jsp:param name="breadcrumb" value="<a href='admin/thresholds/index.jsp?groupName=${groupName}&editGroup'>Edit Group</a>" />
	<jsp:param name="breadcrumb" value="Edit Threshold" />
    
</jsp:include>
<h3>Edit threshold</h3>

<form action="admin/thresholds/index.htm" method="post">
<input type="hidden" name="finishThresholdEdit" value="1"/>
<input type="hidden" name="thresholdIndex" value="${thresholdIndex}"/>
<input type="hidden" name="groupName" value="${groupName}"/>
<input type="hidden" name="isNew" value="${isNew}"/>
  <table class="normal">
    <tr>
    	<td class="standardheader">Type</td>
    	<td class="standardheader">Datasource</td>
    	<td class="standardheader">Datasource type</td>
    	<td class="standardheader">Datasource label</td>
    	<td class="standardheader">Value</td>
    	<td class="standardheader">Re-arm</td>
    	<td class="standardheader">Trigger</td>
    </tr>
    	<tr>
    		<td class="standard">
    			<select name="type">
    				<c:forEach items="${thresholdTypes}" var="thisType">
   						<c:choose>
  							<c:when test="${threshold.type==thisType}">
    							<c:set var="selected" value="selected"/>
  							</c:when>
	 						<c:otherwise>
	    						<c:set var="selected" value=""/>
	  						</c:otherwise>
						</c:choose>
						<option ${selected} value='${thisType}'>${thisType}</option>
    				</c:forEach>
    			</select>
    		</td>
    		<td class="standard"><input type="text" name="dsName" size=30" value="${threshold.dsName}"/></td>
    		<td class="standard">
    		   	<select name="dsType">
    				<c:forEach items="${dsTypes}" var="thisDsType">
   						<c:choose>
  							<c:when test="${threshold.dsType==thisDsType}">
    							<c:set var="selected" value="selected"/>
  							</c:when>
	 						<c:otherwise>
	    						<c:set var="selected" value=""/>
	  						</c:otherwise>
						</c:choose>
						<option ${selected} value='${thisDsType}'>${thisDsType}</option>
    				</c:forEach>
    			</select></td>
 			<td class="standard"><input type="text" name="dsLabel" size=30" value="${threshold.dsLabel}"/></td>
    		<td class="standard"><input type="text" name="value" size=10" value="${threshold.value}"/></td>
    		<td class="standard"><input type="text" name="rearm" size=10" value="${threshold.rearm}"/></td>
    		<td class="standard"><input type="text" name="trigger" size=10" value="${threshold.trigger}"/></td>
    	</tr>
    </table>
    <table class="normal">
         <tr>
                <th class="standardheader">Triggered UEI</th>
                <th class="standardheader">Re-armed UEI</th>
        </tr>
    	<tr>
			<td class="standard"><input type="text" name="triggeredUEI" size="60" value="${threshold.triggeredUEI}"/></td>
		    <td class="standard"><input type="text" name="rearmedUEI" size="60" value="${threshold.rearmedUEI}"/></td>
    	</tr>
  </table>
  <input type="submit" name="submitAction" value="${saveButtonTitle}"/>
  <input type="submit" name="submitAction" value="${cancelButtonTitle}"/>
</form>
<h3>Help</h3>
<p>
<b>Type</b>: A "high" threshold triggers when the value of the data source exceeds the "value", and is re-armed when it drops below the "re-arm" value.<BR>
Conversely, a "low" threshold triggers when the value of the data source drops below the "value", and is re-armed when it exceeds the "re-arm" value<br>
"relativeChange" is for thresholds that trigger when the change in data source value from one collection to the next is greater than "value" percent.<br>
<b>Expression</b>: A  mathematical expression involving datasource names which will be evaluated and compared to the threshold values<br>
<b>Data source type</b>: Node for "node-level" data items, and "interface" for interface-level items.  <br>
<b>Datasource label</b>: The name of the collected "string" type data item to use as a label when reporting this threshold<br>
<b>Value</b>: Use depends on the type of threshold<br>
<b>Re-arm</b>: Use depends on the type of threshold; it is unused/ignored for relativeChange thresholds<br>
<b>Trigger</b>: The number of times the threshold must be "exceeded" in a row before the threshold will be triggered.  Not used for relativeChange thresholds.<br>
<b>Triggered UEI</b>: A custom UEI to send into the events system when this threshold is triggered.  If left blank, it defaults to the standard thresholds UEIs.<br>
<b>Rearmed UEI</b>: A custom UEI to send into the events system when this threshold is re-armed.  If left blank, it defaults to the standard thresholds UEIs.<br>
<b>Example UEIs</b>: A typical UEI is of the format <i>"uei.opennms.org/&lt;category&gt;/&lt;name&gt;"</i>.  It is recommended that when creating custom UEIs for thresholds, you use a one-word version of your company name as the category to avoid name conflicts.  The "name" portion is up to you
</p>
<jsp:include page="/includes/footer.jsp" flush="false"/>