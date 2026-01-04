package vn.edu.hcmute.springboot3_4_12.auth;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import vn.edu.hcmute.springboot3_4_12.entity.User;

import java.util.Objects;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler
    ) throws Exception {

        HttpSession session = request.getSession(false);
        User user = (session != null)
                ? (User) session.getAttribute("user")
                : null;

        String uri = request.getRequestURI();

        // ===== ROLE =====
        String role = (user == null) ? "GUEST" : user.getRole();

        // ===== ADMIN & API =====
        if (uri.startsWith("/admin") || uri.startsWith("/api")) {
            if (!"ADMIN".equals(role)) {
                response.sendRedirect("/login");
                return false;
            }
        }

        // ===== VENDOR =====
        if (uri.startsWith("/vendor")) {
            if (!"VENDOR".equals(role)) {
                response.sendRedirect("/login");
                return false;
            }
        }

        // ===== PUBLIC / GUEST =====
        return true;
    }
}
