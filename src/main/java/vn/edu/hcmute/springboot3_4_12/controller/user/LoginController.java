package vn.edu.hcmute.springboot3_4_12.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import java.util.Optional;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/perform_login")
    public String performLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpServletRequest request) {
        Optional<User> opt = userRepository.findUserByUsername(username);
        if (opt.isEmpty()) {
            request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
            return "login";
        }

        User user = opt.get();
        if (!passwordEncoder.matches(password, user.getPassword())) {
            request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
            return "login";
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);

        if ("ADMIN".equals(user.getRole())) {
            return "redirect:/admin/home";
        }
        return "redirect:/";
    }
}
