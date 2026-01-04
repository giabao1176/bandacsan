package vn.edu.hcmute.springboot3_4_12.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import vn.edu.hcmute.springboot3_4_12.entity.Category;
import vn.edu.hcmute.springboot3_4_12.entity.Product;
import vn.edu.hcmute.springboot3_4_12.entity.Vendor;
import vn.edu.hcmute.springboot3_4_12.repository.CategoryRepository;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import vn.edu.hcmute.springboot3_4_12.repository.UserRepository;
import vn.edu.hcmute.springboot3_4_12.repository.VendorRepository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

/**
 * Class để tự động tạo dữ liệu danh mục và sản phẩm mẫu khi ứng dụng khởi động
 * Chạy sau DataInitializer để đảm bảo user và vendor đã được tạo
 */
@Component
@Order(2) // Chạy sau DataInitializer (mặc định order = 0)
public class CategoryProductInitializer implements CommandLineRunner {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        System.out.println("=== Bắt đầu khởi tạo danh mục và sản phẩm mẫu ===");

        // Tạo các danh mục theo vùng miền
        Category categoryMienBac = createCategoryIfNotExists(
            "Đặc sản Miền Bắc",
            "Northern Specialties",
            "Các món đặc sản nổi tiếng của miền Bắc Việt Nam"
        );

        Category categoryMienTrung = createCategoryIfNotExists(
            "Đặc sản Miền Trung",
            "Central Specialties",
            "Các món đặc sản nổi tiếng của miền Trung Việt Nam"
        );

        Category categoryMienNam = createCategoryIfNotExists(
            "Đặc sản Miền Nam",
            "Southern Specialties",
            "Các món đặc sản nổi tiếng của miền Nam Việt Nam"
        );

        // Lấy vendor để gán sản phẩm
        Optional<Vendor> vendorOpt = vendorRepository.findVendorByUser_Id(
            userRepository.findUserByUsername("vendor1")
                .map(u -> u.getId())
                .orElse(null)
        );

        if (vendorOpt.isEmpty()) {
            // Tạo vendor nếu chưa có
            Vendor vendor = new Vendor();
            vendor.setUser(userRepository.findUserByUsername("vendor1").orElse(null));
            vendor.setStoreName("Cửa hàng Đặc sản Quê hương");
            vendor.setDescriptionVi("Chuyên cung cấp các đặc sản từ khắp mọi miền đất nước");
            vendor.setDescriptionEn("Specialized in providing specialties from all regions of Vietnam");
            vendor.setAddress("123 Đường ABC, Quận XYZ, TP.HCM");
            vendor.setPhone("0123456789");
            vendor = vendorRepository.save(vendor);
            vendorOpt = Optional.of(vendor);
        }

        Vendor vendor = vendorOpt.get();

        // Tạo sản phẩm cho Miền Bắc
        createProductsForMienBac(vendor, categoryMienBac);

        // Tạo sản phẩm cho Miền Trung
        createProductsForMienTrung(vendor, categoryMienTrung);

        // Tạo sản phẩm cho Miền Nam
        createProductsForMienNam(vendor, categoryMienNam);

        System.out.println("=== Hoàn tất khởi tạo danh mục và sản phẩm mẫu ===");
    }

    private Category createCategoryIfNotExists(String nameVi, String nameEn, String description) {
        List<Category> existing = categoryRepository.findAll();
        Optional<Category> found = existing.stream()
            .filter(c -> c.getNameVi() != null && c.getNameVi().equals(nameVi))
            .findFirst();

        if (found.isPresent()) {
            System.out.println("✓ Danh mục '" + nameVi + "' đã tồn tại");
            return found.get();
        }

        Category category = new Category();
        category.setNameVi(nameVi);
        category.setNameEn(nameEn);
        category = categoryRepository.save(category);
        System.out.println("✓ Đã tạo danh mục: " + nameVi);
        return category;
    }

    private void createProductsForMienBac(Vendor vendor, Category category) {
        List<Product> products = Arrays.asList(
            createProductIfNotExists(
                "Bánh chưng",
                "Chung Cake",
                "Bánh chưng là món ăn truyền thống của người Việt Nam, đặc biệt trong dịp Tết Nguyên Đán. Bánh được làm từ gạo nếp, đậu xanh, thịt lợn và lá dong.",
                "Chung cake is a traditional Vietnamese dish, especially during Tet holiday. Made from sticky rice, mung beans, pork, and dong leaves.",
                150000.0,
                50,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Phở Hà Nội",
                "Hanoi Pho",
                "Phở Hà Nội là món ăn nổi tiếng nhất của thủ đô, với nước dùng trong, thơm ngon và bánh phở mềm mại.",
                "Hanoi Pho is the most famous dish of the capital, with clear, fragrant broth and soft rice noodles.",
                80000.0,
                100,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Bún chả",
                "Grilled Pork with Noodles",
                "Bún chả Hà Nội với thịt nướng thơm lừng, nước mắm chua ngọt đậm đà, ăn kèm bún tươi và rau sống.",
                "Hanoi bun cha with fragrant grilled pork, sweet and sour fish sauce, served with fresh noodles and herbs.",
                70000.0,
                80,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Nem Phùng",
                "Phung Spring Rolls",
                "Nem Phùng là đặc sản của Hà Nội, nem được cuốn từ thịt lợn, mộc nhĩ, miến và các gia vị đặc trưng.",
                "Phung spring rolls are a specialty of Hanoi, made from pork, wood ear mushrooms, glass noodles and special spices.",
                120000.0,
                60,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Cốm làng Vòng",
                "Vong Village Green Rice",
                "Cốm làng Vòng là đặc sản nổi tiếng của Hà Nội, được làm từ lúa nếp non, có vị ngọt thanh, thơm mát.",
                "Vong village green rice is a famous specialty of Hanoi, made from young sticky rice, with a sweet, fresh and fragrant taste.",
                200000.0,
                40,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Chả cá Lã Vọng",
                "La Vong Grilled Fish",
                "Chả cá Lã Vọng là món ăn đặc trưng của Hà Nội, cá được nướng trên than hoa, ăn kèm bún, rau thơm và nước mắm gừng.",
                "La Vong grilled fish is a specialty of Hanoi, fish grilled over charcoal, served with noodles, herbs and ginger fish sauce.",
                180000.0,
                45,
                vendor,
                Arrays.asList(category)
            )
        );

        System.out.println("✓ Đã tạo " + products.size() + " sản phẩm cho danh mục Đặc sản Miền Bắc");
    }

    private void createProductsForMienTrung(Vendor vendor, Category category) {
        List<Product> products = Arrays.asList(
            createProductIfNotExists(
                "Bún bò Huế",
                "Hue Beef Noodle Soup",
                "Bún bò Huế là món ăn đặc trưng của xứ Huế, với nước dùng đậm đà, cay nồng, thịt bò mềm và bún to.",
                "Hue beef noodle soup is a specialty of Hue, with rich, spicy broth, tender beef and thick noodles.",
                85000.0,
                90,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Bánh bèo Huế",
                "Hue Water Fern Cake",
                "Bánh bèo Huế là món ăn vặt nổi tiếng, bánh nhỏ xinh, ăn kèm tôm chấy, mỡ hành và nước mắm chua ngọt.",
                "Hue water fern cake is a famous snack, small and cute, served with dried shrimp, scallion oil and sweet and sour fish sauce.",
                60000.0,
                120,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Nem nướng Nha Trang",
                "Nha Trang Grilled Pork Sausage",
                "Nem nướng Nha Trang với thịt nướng thơm lừng, ăn kèm bánh tráng, rau sống và nước mắm pha chế đặc biệt.",
                "Nha Trang grilled pork sausage with fragrant grilled meat, served with rice paper, fresh herbs and special dipping sauce.",
                95000.0,
                70,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Cao lầu Hội An",
                "Hoi An Cao Lau",
                "Cao lầu Hội An là món ăn độc đáo, sợi mì vàng, thịt heo quay, rau sống và nước dùng đậm đà.",
                "Hoi An cao lau is a unique dish, with yellow noodles, roasted pork, fresh herbs and rich broth.",
                90000.0,
                65,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Bánh xèo",
                "Vietnamese Pancake",
                "Bánh xèo miền Trung với lớp vỏ giòn tan, nhân tôm thịt đầy đặn, ăn kèm rau sống và nước mắm chua ngọt.",
                "Central Vietnamese pancake with crispy shell, full of shrimp and pork filling, served with fresh herbs and sweet and sour fish sauce.",
                75000.0,
                85,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Mắm tôm chua",
                "Fermented Shrimp Paste",
                "Mắm tôm chua là đặc sản của miền Trung, có vị chua cay đặc trưng, dùng để chấm hoặc làm gia vị.",
                "Fermented shrimp paste is a specialty of Central Vietnam, with a characteristic sour and spicy taste, used for dipping or as a condiment.",
                150000.0,
                55,
                vendor,
                Arrays.asList(category)
            )
        );

        System.out.println("✓ Đã tạo " + products.size() + " sản phẩm cho danh mục Đặc sản Miền Trung");
    }

    private void createProductsForMienNam(Vendor vendor, Category category) {
        List<Product> products = Arrays.asList(
            createProductIfNotExists(
                "Bánh mì Sài Gòn",
                "Saigon Baguette",
                "Bánh mì Sài Gòn nổi tiếng với lớp vỏ giòn, nhân đa dạng gồm thịt, pate, chả lụa, rau củ và gia vị.",
                "Saigon baguette is famous for its crispy crust, diverse fillings including meat, pate, Vietnamese ham, vegetables and condiments.",
                35000.0,
                150,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Hủ tiếu Nam Vang",
                "Nam Vang Noodle Soup",
                "Hủ tiếu Nam Vang với sợi hủ tiếu trong suốt, nước dùng ngọt thanh, thịt heo, tôm và trứng cút.",
                "Nam Vang noodle soup with transparent noodles, sweet and clear broth, pork, shrimp and quail eggs.",
                65000.0,
                100,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Bánh tét",
                "Tet Sticky Rice Cake",
                "Bánh tét là món ăn truyền thống của miền Nam trong dịp Tết, được làm từ gạo nếp, đậu xanh và thịt heo.",
                "Tet sticky rice cake is a traditional Southern dish during Tet, made from sticky rice, mung beans and pork.",
                180000.0,
                50,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Cá kho tộ",
                "Braised Fish in Clay Pot",
                "Cá kho tộ là món ăn đặc trưng của miền Nam, cá được kho với nước dừa, nước mắm và gia vị đậm đà.",
                "Braised fish in clay pot is a specialty of the South, fish braised with coconut water, fish sauce and rich spices.",
                120000.0,
                60,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Bánh canh",
                "Thick Noodle Soup",
                "Bánh canh với sợi bánh dày, nước dùng đậm đà từ xương heo, thịt heo, tôm và các loại chả.",
                "Thick noodle soup with thick noodles, rich broth from pork bones, pork, shrimp and various Vietnamese ham.",
                70000.0,
                80,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Gỏi cuốn",
                "Fresh Spring Rolls",
                "Gỏi cuốn tươi với bánh tráng, tôm, thịt, bún và rau sống, chấm với nước mắm pha chế đặc biệt.",
                "Fresh spring rolls with rice paper, shrimp, meat, noodles and fresh herbs, served with special dipping sauce.",
                60000.0,
                110,
                vendor,
                Arrays.asList(category)
            ),
            createProductIfNotExists(
                "Chè đậu xanh",
                "Mung Bean Sweet Soup",
                "Chè đậu xanh là món tráng miệng phổ biến của miền Nam, ngọt thanh, mát lạnh, thích hợp cho mùa hè.",
                "Mung bean sweet soup is a popular Southern dessert, sweet and refreshing, perfect for summer.",
                30000.0,
                130,
                vendor,
                Arrays.asList(category)
            )
        );

        System.out.println("✓ Đã tạo " + products.size() + " sản phẩm cho danh mục Đặc sản Miền Nam");
    }

    private Product createProductIfNotExists(String nameVi, String nameEn, 
                                            String descVi, String descEn,
                                            Double price, Integer stock,
                                            Vendor vendor, List<Category> categories) {
        // Kiểm tra xem sản phẩm đã tồn tại chưa
        List<Product> existing = productRepository.findByNameViContaining(nameVi);
        Optional<Product> found = existing.stream()
            .filter(p -> p.getNameVi() != null && p.getNameVi().equals(nameVi))
            .findFirst();

        if (found.isPresent()) {
            // Cập nhật danh mục nếu sản phẩm đã tồn tại
            // Fetch lại product với categories để tránh lazy loading exception
            Product product = productRepository.findById(found.get().getId())
                .orElse(found.get());
            
            // Kiểm tra và cập nhật categories
            List<Category> currentCategories = product.getCategories();
            if (currentCategories == null || currentCategories.isEmpty()) {
                product.setCategories(categories);
                productRepository.save(product);
                System.out.println("  ✓ Đã cập nhật danh mục cho sản phẩm: " + nameVi);
            } else {
                System.out.println("  ✓ Sản phẩm '" + nameVi + "' đã có danh mục");
            }
            return product;
        }

        // Tạo sản phẩm mới
        Product product = new Product();
        product.setNameVi(nameVi);
        product.setNameEn(nameEn);
        product.setDescriptionVi(descVi);
        product.setDescriptionEn(descEn);
        product.setPrice(price);
        product.setStock(stock);
        product.setVendor(vendor);
        product.setCategories(categories);
        
        product = productRepository.save(product);
        System.out.println("  ✓ Đã tạo sản phẩm: " + nameVi);
        return product;
    }
}

