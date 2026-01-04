package vn.edu.hcmute.springboot3_4_12.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.dto.*;
import vn.edu.hcmute.springboot3_4_12.entity.*;
import vn.edu.hcmute.springboot3_4_12.repository.*;
import vn.edu.hcmute.springboot3_4_12.service.ICartService;
import vn.edu.hcmute.springboot3_4_12.service.IOrderService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class OrderService implements IOrderService {

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final PaymentRepository paymentRepository;
    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final UserRepository userRepository;
    private final ICartService cartService;

    @Override
    public OrderDTO createOrder(Long userId, CheckoutRequestDTO request) {
        // Get user's cart
        CartDTO cart = cartService.getCartByUserId(userId);
        if (cart.getItems().isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống");
        }

        // Create order
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        Order order = new Order();
        order.setUser(user);

        order.setTotalAmount(cart.getTotalPrice());
        order.setStatus(OrderStatus.PENDING);
        order = orderRepository.save(order);

        // Create order items
        for (CartItemDTO cartItem : cart.getItems()) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);

            // Get product from repository to ensure it's managed
            Product product = cartItemRepository.findById(cartItem.getId())
                    .map(CartItem::getProduct)
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            orderItem.setProduct(product);
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(product.getPrice());

            orderItemRepository.save(orderItem);
        }

        // Create payment
        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setMethod(request.getPaymentMethod() != null ? request.getPaymentMethod() : "COD");
        payment.setStatus("PENDING");
        paymentRepository.save(payment);

        // Clear cart
        cartService.clearCart(userId);

        return convertToDTO(order);
    }

    @Override
    public List<OrderDTO> getUserOrders(Long userId) {
        return orderRepository.findByUser_IdOrderByIdDesc(userId)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public OrderDTO getOrderById(Long orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        // Check if order belongs to user (or user is admin)
        if (!order.getUser().getId().equals(userId)) {
            // TODO: Add admin check
            throw new RuntimeException("Access denied");
        }

        return convertToDTO(order);
    }

    @Override
    public OrderDTO updateOrderStatus(Long orderId, OrderStatus status) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));

        order.setStatus(status);
        order = orderRepository.save(order);

        return convertToDTO(order);
    }

    @Override
    public List<OrderDTO> getAllOrders() {
        return orderRepository.findAll()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public List<OrderDTO> getOrdersByStatus(OrderStatus status) {
        return orderRepository.findByStatus(status)
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public Order findOrderById(Long l) {
        return orderRepository.findOrderById(l);
    }

    @Override
    @Transactional
    public void updateStatus(long orderId, String status) {
        // 1. Tìm thông tin thanh toán dựa trên orderId
        Payment payment = paymentRepository.findByOrder_Id(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy thông tin thanh toán cho đơn hàng: " + orderId));

        // 2. Cập nhật trạng thái thanh toán (ví dụ: "PAID", "FAILED")
        payment.setStatus(status);
        paymentRepository.save(payment);

        // 3. Cập nhật trạng thái đơn hàng tương ứng
        Order order = payment.getOrder();
        if ("PAID".equalsIgnoreCase(status)) {
            order.setStatus(OrderStatus.PROCESSING); // Hoặc trạng thái bạn quy định sau khi thanh toán
            // Có thể thêm logic trừ kho sản phẩm ở đây nếu cần
        } else if ("FAILED".equalsIgnoreCase(status)) {
            order.setStatus(OrderStatus.CANCELLED);
        }

        orderRepository.save(order);
    }

    private OrderDTO convertToDTO(Order order) {
        List<OrderItemDTO> itemDTOs = orderItemRepository.findByOrder_Id(order.getId())
                .stream()
                .map(this::convertItemToDTO)
                .collect(Collectors.toList());

        PaymentDTO paymentDTO = paymentRepository.findByOrder_Id(order.getId())
                .map(this::convertPaymentToDTO)
                .orElse(null);

        return new OrderDTO(
                order.getId(),
                order.getUser().getId(),
                order.getUser().getUsername(),
                order.getTotalAmount(),
                order.getStatus(),
                null, // TODO: Add createdAt field to Order entity
                itemDTOs,
                paymentDTO
        );
    }

    private OrderItemDTO convertItemToDTO(OrderItem item) {
        // 1. Tính toán subtotal
        Double subtotal = item.getPrice() * item.getQuantity();

        // 2. Tìm hình ảnh chính (main = true) từ danh sách images của Product
        String mainImage = item.getProduct().getImages().stream()
                .filter(Image::isMain) // Lọc những ảnh có main = true
                .map(Image::getUrl)    // Lấy ra chuỗi URL (tên file)
                .findFirst()           // Lấy ảnh đầu tiên tìm thấy
                .orElse(null);         // Nếu không có ảnh main nào thì trả về null

        // 3. Trả về DTO hoàn chỉnh
        return new OrderItemDTO(
                item.getId(),
                item.getProduct().getId(),
                item.getProduct().getNameVi(),
                item.getProduct().getNameEn(),
                mainImage,              // Gán ảnh chính vào productImage
                item.getQuantity(),
                item.getPrice(),
                subtotal
        );
    }

    private PaymentDTO convertPaymentToDTO(Payment payment) {
        return new PaymentDTO(
                payment.getId(),
                payment.getOrder().getId(),
                payment.getMethod(),
                payment.getStatus(),
                payment.getTransactionId()
        );
    }
}
