package vn.edu.hcmute.springboot3_4_12.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Collections;
import java.util.List;
import vn.edu.hcmute.springboot3_4_12.dto.UserResponseDTO;
import vn.edu.hcmute.springboot3_4_12.dto.CategoryResponseDTO;
import vn.edu.hcmute.springboot3_4_12.dto.ProductResponseDTO;
import vn.edu.hcmute.springboot3_4_12.dto.VendorResponseDTO;
import vn.edu.hcmute.springboot3_4_12.service.IUserService;
import vn.edu.hcmute.springboot3_4_12.service.ICategoryService;
import vn.edu.hcmute.springboot3_4_12.service.IProductService;
import vn.edu.hcmute.springboot3_4_12.service.impl.VendorService;

@Controller
public class AdminPageController {
    @Autowired
    private IUserService userService;

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private IProductService productService;

    @Autowired
    private VendorService vendorService;

    @GetMapping({"/admin", "/admin/home"})
    public String dashboard(Model model) {
        try {
            List<UserResponseDTO> users = userService.getAllUsers();
            List<CategoryResponseDTO> categories = categoryService.getAll();
            List<ProductResponseDTO> products = productService.getAll();
            List<VendorResponseDTO> vendors = vendorService.findAll();

            model.addAttribute("users", users != null ? users : Collections.emptyList());
            model.addAttribute("categories", categories != null ? categories : Collections.emptyList());
            model.addAttribute("products", products != null ? products : Collections.emptyList());
            model.addAttribute("vendors", vendors != null ? vendors : Collections.emptyList());

            return "admin/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("users", Collections.emptyList());
            model.addAttribute("categories", Collections.emptyList());
            model.addAttribute("products", Collections.emptyList());
            model.addAttribute("vendors", Collections.emptyList());
            return "admin/dashboard";
        }
    }
}
