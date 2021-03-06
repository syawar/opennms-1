/*******************************************************************************
 * This file is part of OpenNMS(R).
 *
 * Copyright (C) 2011-2012 The OpenNMS Group, Inc.
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

package org.opennms.features.gwt.graph.resource.list.client.event;

import com.google.gwt.event.shared.GwtEvent;

public class SearchClickEvent extends GwtEvent<SearchClickEventHandler> {
    
    public static Type<SearchClickEventHandler> TYPE = new Type<SearchClickEventHandler>();
    private String m_searchTerm;

    public SearchClickEvent(String searchTerm) {
        m_searchTerm = searchTerm;
    }
    
    public static Type<SearchClickEventHandler> getType(){
        return TYPE;
    }
    
    @Override
    public Type<SearchClickEventHandler> getAssociatedType() {
        return TYPE;
    }

    @Override
    protected void dispatch(SearchClickEventHandler handler) {
        handler.onSearchClickEvent(m_searchTerm);
    }

}
