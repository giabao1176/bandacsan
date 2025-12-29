package vn.edu.hcmute.springboot3_4_12.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;


public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		// Loại trừ các trang không cần decorator
		builder.addExcludedPath("/login");
		builder.addExcludedPath("/register");
		builder.addExcludedPath("/error");
		builder.addExcludedPath("/api/*");
		builder.addExcludedPath("/resources/*");
		builder.addExcludedPath("/perform_login");
		
		// Decorator cho admin
		builder.addDecoratorPath("/admin/*", "/WEB-INF/decorators/admin-decorator.jsp");
		
		// Decorator cho vendor
		builder.addDecoratorPath("/vendor/*", "/WEB-INF/decorators/vendor-decorator.jsp");
		
		// Decorator mặc định cho user (bao gồm /user/* và các trang khác)
		builder.addDecoratorPath("/user/*", "/WEB-INF/decorators/user-decorator.jsp");
		builder.addDecoratorPath("/*", "/WEB-INF/decorators/user-decorator.jsp");
	}
}
