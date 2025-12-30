package vn.edu.hcmute.springboot3_4_12.controller.admin;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.impl.VendorService;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/products")
@RequiredArgsConstructor
public class ProductPageController {

    private final IProductService productService;
    private final ICategoryService categoryService;
    private final VendorService vendorService;
    private final ProductRepository productRepository;

    // Trang danh sách sản phẩm
    @GetMapping
    public String listPage(Model model) {
        model.addAttribute("products", productService.getAll());
        return "admin/product/list";
    }

    // Trang thêm mới sản phẩm
    @GetMapping("/create")
    public String createPage(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        model.addAttribute("vendors", vendorService.findAll());
        return "admin/product/form";
    }

    // Trang chỉnh sửa sản phẩm
    @GetMapping("/edit/{id}")
    @Transactional
    public String editPage(@PathVariable Long id, Model model) {
        try {
            var productDTO = productService.findById(id);
            model.addAttribute("product", productDTO);
            model.addAttribute("categories", categoryService.getAll());
            model.addAttribute("vendors", vendorService.findAll());
            
            // Lấy category IDs từ product entity để pre-select
            var productEntity = productRepository.findById(id);
            if (productEntity.isPresent()) {
                // Force load categories để tránh LazyInitializationException
                var categories = productEntity.get().getCategories();
                var categoryIds = categories.stream()
                    .map(cat -> cat.getId() != null ? cat.getId() : 0L)
                    .filter(id -> id > 0)
                    .collect(java.util.stream.Collectors.toList());
                model.addAttribute("selectedCategoryIds", categoryIds);
            }
            
            return "admin/product/form";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Không tìm thấy sản phẩm: " + e.getMessage());
            return "redirect:/admin/products";
        }
    }
}