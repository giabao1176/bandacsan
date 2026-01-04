// document.querySelectorAll('.add-to-cart-btn').forEach(button => {
//     button.addEventListener('click', function() {
//         const product = {
//             id: this.dataset.id,
//             name: this.dataset.name,
//             price: this.dataset.price,
//             image: this.dataset.image,
//             quantity: 1
//         };
//
//         // Kiểm tra trạng thái đăng nhập (giả sử có biến global từ session)
//         const isLoggedIn = ${sessionScope.user != null ? 'true' : 'false'};
//
//         if (isLoggedIn) {
//             addToCartServer(product);
//         } else {
//             addToCartLocal(product);
//         }
//     });
// });
//
// // Xử lý cho người dùng chưa đăng nhập (LocalStorage)
// function addToCartLocal(product) {
//     let cart = JSON.parse(localStorage.getItem('cart')) || [];
//     const index = cart.findIndex(item => item.id === product.id);
//
//     if (index > -1) {
//         cart[index].quantity += 1;
//     } else {
//         cart.push(product);
//     }
//
//     localStorage.setItem('cart', JSON.stringify(cart));
//     alert('Đã thêm vào giỏ hàng (Local)!');
//     updateCartBadge(); // Hàm cập nhật số lượng trên header
// }
//
// // Xử lý cho người dùng đã đăng nhập (AJAX tới Controller)
// function addToCartServer(product) {
//     fetch('<c:url value="/user/cart/add"/>', {
//         method: 'POST',
//         headers: { 'Content-Type': 'application/json' },
//         body: JSON.stringify({
//             productId: product.id,
//             quantity: 1
//         })
//     })
//         .then(res => res.json())
//         .then(data => {
//             alert('Đã thêm vào giỏ hàng hệ thống!');
//             // Cập nhật số lượng từ response của server
//         })
//         .catch(err => console.error('Lỗi:', err));
// }