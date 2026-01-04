package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.edu.hcmute.springboot3_4_12.dto.CartDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CheckoutRequestDTO;
import vn.edu.hcmute.springboot3_4_12.dto.OrderDTO;
import vn.edu.hcmute.springboot3_4_12.service.ICartService;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.springboot3_4_12.entity.User;
import vn.edu.hcmute.springboot3_4_12.service.impl.MomoService;

import java.util.Map;

@Controller
@RequestMapping("/user/checkout")
@RequiredArgsConstructor
public class CheckoutController {

    private final ICartService cartService;
    private final IOrderService orderService;
    private  final MomoService momoService;
    @GetMapping
    public String checkoutPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            CartDTO cart = cartService.getCartByUserId(user.getId());
            if (cart.getItems().isEmpty()) {
                return "redirect:/user/cart?error=Giỏ hàng trống";
            }

            model.addAttribute("cart", cart);
            return "user/checkout";
        } catch (Exception e) {
            return "redirect:/user/cart?error=" + e.getMessage();
        }
    }


    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> processCheckout(@RequestBody CheckoutRequestDTO request, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Vui lòng đăng nhập");

        try {
            // 1. Tạo đơn hàng trong DB trước (Trạng thái PENDING)
            OrderDTO orderDTO = orderService.createOrder(user.getId(), request);

            // 2. Kiểm tra phương thức thanh toán
            if ("MOMO".equalsIgnoreCase(request.getPaymentMethod())) {
                // Lấy thực thể Order từ DB để truyền vào MomoService
                vn.edu.hcmute.springboot3_4_12.entity.Order order = orderService.findOrderById((orderDTO.getId()));

                // 3. Gọi MomoService để lấy link thanh toán
                String payUrl = momoService.getMomoPayUrl(order);

                // Trả về một Map chứa URL để phía Javascript chuyển hướng
                return ResponseEntity.ok(Map.of("payUrl", payUrl));
            }

            // Nếu là COD hoặc phương thức khác
            return ResponseEntity.ok(orderDTO);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Lỗi: " + e.getMessage());
        }
    }
}
