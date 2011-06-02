package org.opennms.web.svclayer.support;

import org.opennms.web.svclayer.SecurityContextService;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

public class SpringSecurityContextService implements SecurityContextService {

	private SecurityContext m_context;
	
	public SpringSecurityContextService() {
		this.m_context = SecurityContextHolder.getContext();
	}
	
	@Override
	public String getUsername() {
		return getUserDetails().getUsername();
	}
	
	@Override
	public String getPassword() {
		return getUserDetails().getPassword();
	}
	
	private UserDetails getUserDetails() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    UserDetails userDetails = null;
	    if (principal instanceof UserDetails) {
	      userDetails = (UserDetails) principal;
	    }
	    return userDetails;
	}
	
	@Override
	public boolean hasRole(String role) {
		boolean hasRole = false;
		UserDetails userDetails = getUserDetails();
		if (userDetails != null) {

			GrantedAuthority[] authorities = userDetails.getAuthorities();
			if (isRolePresent(authorities, role)) {
				hasRole = true;
			}
		}
		return hasRole;
	}

	@Override
	public boolean isAuthenticated() {
		return this.m_context.getAuthentication().isAuthenticated();
	}
	
	/**
	 * Check if the currently logged in user is present in authorities of
	 * current user
	 * 
	 * @param authorities
	 *            - all assigned authorities
	 * @param role
	 *            - required role authority
	 * @return true if role is present, otherwise false
	 */
	private boolean isRolePresent(GrantedAuthority[] authorities, String role) {
		boolean isRolePresent = false;
		for (GrantedAuthority grantedAuthority : authorities) {
			isRolePresent = grantedAuthority.getAuthority().equals(role);
			if (isRolePresent)
				break;
		}
		return isRolePresent;
	}
}
