package vn.edu.hcmute.springboot3_4_12.controller;

import ch.qos.logback.core.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;

import java.util.Map;

@RestController
@RequestMapping("/user/checkout")
public class MomoCallbackController {

    @Autowired
    private IOrderService orderService;

    // 1. Nhận kết quả ngầm từ MoMo (IPN)
    @PostMapping("/momo-ipn")
    public ResponseEntity<Void> handleMomoIPN(@RequestBody Map<String, Object> payload) {
        String orderId = payload.get("orderId").toString();
        String resultCode = payload.get("resultCode").toString();

        if ("0".equals(resultCode)) {
            // Thanh toán thành công -> Cập nhật DB
            orderService.updateStatus(Long.parseLong(orderId), "PAID");
        }

        return ResponseEntity.noContent().build(); // Phản hồi để MoMo không gửi lại
    }

    // 2. Nhận người dùng quay lại web (Redirect)
    @GetMapping("/momo-return")
    public String handleMomoReturn(@RequestParam Map<String, String> params, Model model) {
        String resultCode = params.get("resultCode");
        if ("0".equals(resultCode)) {
            return "redirect:/user/orders";
        }
        return "redirect:/user/checkout";
    }
}
