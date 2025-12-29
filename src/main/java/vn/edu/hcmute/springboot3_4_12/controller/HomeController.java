package vn.edu.hcmute.springboot3_4_12.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import vn.edu.hcmute.springboot3_4_12.entity.User;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Chưa đăng nhập -> redirect về login
            return "redirect:/login";
        }
        
        User user = (User) session.getAttribute("user");
        String role = user.getRole();
        
        // Redirect theo role
        if ("ADMIN".equals(role)) {
            return "redirect:/admin/home";
        } else if ("VENDOR".equals(role)) {
            return "redirect:/vendor/dashboard";
        } else {
            // USER/CUSTOMER
            return "redirect:/user/home";
        }
    }
}

