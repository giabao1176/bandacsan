package vn.edu.hcmute.springboot3_4_12.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MomoPaymentRequest {
    private String partnerCode;
    private String partnerName;
    private String storeId;
    private String requestId;
    private String amount;
    private String orderId;
    private String orderInfo;
    private String redirectUrl;
    private String ipnUrl;
    private String lang;
    private String extraData;
    private String requestType;
    private String signature;
}