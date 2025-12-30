package vn.edu.hcmute.springboot3_4_12.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.repository.ProductRepository;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserContentController {

    private final ICategoryService categoryService;
    private final IProductService productService;
    private final ProductRepository productRepository;

    @GetMapping("/categories")
    public String categories(Model model) {
        // Provide categories to the JSP view
        model.addAttribute("categories", categoryService.getAll());
        return "user/category/list";
    }

    @GetMapping("/products")
    public String products(
            @RequestParam(required = false) Long categoryId,
            Model model) {
        
        List<vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO> products;
        
        if (categoryId != null) {
            // Lọc sản phẩm theo category
            var productEntities = productRepository.findByCategories_Id(categoryId);
            products = productEntities.stream()
                    .map(productService::convertToResponseDTO)
                    .collect(Collectors.toList());
            
            // Lấy thông tin category để hiển thị
            var category = categoryService.findById(categoryId);
            if (category.isPresent()) {
                model.addAttribute("selectedCategory", category.get());
            }
        } else {
            // Hiển thị tất cả sản phẩm
            products = productService.getAll();
        }
        
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.getAll());
        return "user/product/list";
    }
}
