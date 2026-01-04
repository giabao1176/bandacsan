package vn.edu.hcmute.springboot3_4_12.service.impl;


import org.apache.hc.client5.http.utils.Hex;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import vn.edu.hcmute.springboot3_4_12.dto.MomoPaymentRequest;
import vn.edu.hcmute.springboot3_4_12.entity.Order;
import org.springframework.beans.factory.annotation.Value;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.util.Map;
import java.util.UUID;

@Service
public class MomoService {
    @Value("${momo.partner-code}")
    private String partnerCode;

    @Value("${momo.access-key}")
    private String accessKey;

    @Value("${momo.secret-key}")
    private String secretKey;

    @Value("${momo.endpoint}")
    private String endpoint;

    @Value("${app.base-url}")
    private String baseUrl;

    public String createSignature(String rawData) throws Exception {
        SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(secretKeySpec);
        byte[] rawHmac = mac.doFinal(rawData.getBytes());
        return Hex.encodeHexString(rawHmac);
    }

    public String getMomoPayUrl(@NonNull Order order) throws Exception {
        String requestId = UUID.randomUUID().toString();
        String orderId =order.getId().toString();
        String amount = String.valueOf(order.getTotalAmount().longValue());
        String orderInfo = "Thanh toán đơn hàng #" + orderId;
        String redirectUrl = baseUrl + "/user/checkout/momo-return";
        String ipnUrl = baseUrl + "/user/checkout/momo-ipn";
        String requestType = "captureWallet";
        String extraData = "";

        // Tạo chuỗi raw signature theo đúng thứ tự MoMo quy định
        String rawSignature = "accessKey=" + accessKey + "&amount=" + amount + "&extraData=" + extraData
                + "&ipnUrl=" + ipnUrl + "&orderId=" + orderId + "&orderInfo=" + orderInfo
                + "&partnerCode=" + partnerCode + "&redirectUrl=" + redirectUrl
                + "&requestId=" + requestId + "&requestType=" + requestType;

        String signature = createSignature(rawSignature);

        // Gọi API MoMo bằng RestTemplate
        MomoPaymentRequest requestBody = MomoPaymentRequest.builder()
                .partnerCode(partnerCode).partnerName("Test").storeId("MomoTestStore")
                .requestId(requestId).amount(amount).orderId(orderId).orderInfo(orderInfo)
                .redirectUrl(redirectUrl).ipnUrl(ipnUrl).lang("vi").extraData(extraData)
                .requestType(requestType).signature(signature).build();

        RestTemplate restTemplate = new RestTemplate();
        Map<String, Object> response = restTemplate.postForObject(endpoint, requestBody, Map.class);

        if (response != null && response.containsKey("payUrl") && response.get("payUrl") != null) {
            return response.get("payUrl").toString();
        } else {
            // Log lỗi để biết MoMo trả về gì nếu thất bại
            System.err.println("MoMo response: " + response);
            assert response != null;
            throw new RuntimeException("Không nhận được payUrl từ MoMo. Mã lỗi: " + response.get("resultCode"));
        }
    }
}