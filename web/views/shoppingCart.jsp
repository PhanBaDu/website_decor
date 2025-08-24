<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Giỏ Hàng</title>
        <link rel="icon" type="image/x-icon" href="icon-title.ico" />
        <link rel="stylesheet" href="./assets/css/globals.css" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../inc/home/header.jsp" />

        <div class="flex-1 w-full flex max-w-7xl mx-auto mt-24 pb-24 gap-6">
            <!-- Danh sách sản phẩm -->
            <div class="w-3/5 bg-background p-6 rounded-lg">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="font-semibold text-sm">Giỏ hàng (${cartCount} sản phẩm)</h2>
                    <div class="flex items-center gap-2">
                        <input type="checkbox" id="selectAll" class="w-4 h-4 text-primary" />
                        <label for="selectAll" class="text-sm">Chọn tất cả</label>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="text-center py-12">
                            <div class="text-6xl mb-4">🛒</div>
                            <h3 class="text-sm font-medium mb-2">Giỏ hàng trống</h3>
                            <p class="text-muted-foreground mb-4 text-sm">
                                Bạn chưa có sản phẩm nào trong giỏ hàng
                            </p>
                            <a
                                href="home"
                                class="inline-flex items-center px-4 py-2 bg-primary text-primary-foreground rounded-md hover:bg-primary/90 text-sm"
                            >
                                Tiếp tục mua sắm
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="space-y-4">
                            <c:forEach var="cartItem" items="${cartItems}">
                                <div class="border rounded-lg p-4" data-cart-id="${cartItem.id}">
                                    <div class="flex items-start gap-4">
                                        <!-- Hình ảnh sản phẩm -->
                                        <img
                                            class="w-20 h-20 object-cover rounded-lg text-sm"
                                            src="${cartItem.product.image}"
                                            alt="${cartItem.product.name}"
                                        />

                                        <!-- Thông tin sản phẩm -->
                                        <div class="flex-1">
                                            <div class="flex gap-4 items-center">
                                                <h3 class="font-medium mb-1 text-sm">
                                                    ${cartItem.product.name}
                                                </h3>

                                                <!-- Nút xóa -->
                                                <form
                                                    method="GET"
                                                    action="remove-from-cart"
                                                    style="display: inline"
                                                >
                                                    <input
                                                        type="hidden"
                                                        name="cartId"
                                                        value="${cartItem.id}"
                                                    />
                                                    <button
                                                        type="submit"
                                                        class="text-red-500 hover:text-red-700 text-sm cursor-pointer"
                                                        onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')"
                                                    >
                                                        <svg
                                                            xmlns="http://www.w3.org/2000/svg"
                                                            width="16"
                                                            height="16"
                                                            viewBox="0 0 24 24"
                                                            fill="none"
                                                            stroke="currentColor"
                                                            stroke-width="2"
                                                            stroke-linecap="round"
                                                            stroke-linejoin="round"
                                                            class="lucide lucide-trash-icon lucide-trash"
                                                        >
                                                            <path
                                                                d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6"
                                                            />
                                                            <path d="M3 6h18" />
                                                            <path
                                                                d="M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
                                                            />
                                                        </svg>
                                                    </button>
                                                </form>
                                            </div>
                                            <p class="text-sm text-muted-foreground mb-2 text-xs">
                                                Còn lại: ${cartItem.product.quantity} sản phẩm
                                            </p>
                                            <div class="text-lg font-semibold text-primary text-sm">
                                                <fmt:formatNumber
                                                    value="${cartItem.price}"
                                                    type="number"
                                                    pattern="#,###"
                                                />đ
                                            </div>
                                        </div>

                                        <!-- Điều chỉnh số lượng -->
                                        <div class="flex flex-col items-end gap-2 mt-2">
                                            <div class="flex items-center border rounded-md">
                                                <button
                                                    type="button"
                                                    class="quantity-btn px-3 py-1 hover:bg-muted"
                                                >
                                                    -
                                                </button>
                                                <span class="px-3 py-1 w-16 text-center text-sm">
                                                    ${cartItem.quantity}
                                                </span>
                                                <button
                                                    type="button"
                                                    class="quantity-btn px-3 py-1 hover:bg-muted text-sm"
                                                >
                                                    +
                                                </button>
                                            </div>

                                            <!-- Tổng tiền cho sản phẩm này -->
                                            <div class="text-sm text-muted-foreground text-sm">
                                                Tổng:
                                                <span
                                                    class="font-medium text-primary item-total text-sm"
                                                >
                                                    <fmt:formatNumber
                                                        value="${cartItem.subtotal}"
                                                        type="number"
                                                        pattern="#,###"
                                                    />đ
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

                         <!-- Thanh toán -->
             <div class="w-2/5 bg-background p-6 rounded-lg h-fit">
                 <h3 class="text-sm font-semibold mb-4">Thông tin thanh toán</h3>
 
                 <div class="space-y-3 mb-6">
                     <div class="flex justify-between text-sm">
                         <span>Tạm tính:</span>
                         <span id="subtotal">
                             <fmt:formatNumber
                                 value="${totalAmount}"
                                 type="number"
                                 pattern="#,###"
                             />đ
                         </span>
                     </div>
                     <div class="flex justify-between text-sm">
                         <span>Phí vận chuyển:</span>
                         <span id="shipping">
                             <c:choose>
                                 <c:when test="${cartCount > 0}">30,000đ</c:when>
                                 <c:otherwise>0đ</c:otherwise>
                             </c:choose>
                         </span>
                     </div>
                     <hr class="my-2" />
                     <div class="flex justify-between text-sm font-semibold">
                         <span>Tổng cộng:</span>
                         <span id="total">
                             <c:choose>
                                 <c:when test="${cartCount > 0}">
                                     <fmt:formatNumber
                                         value="${totalAmount + 30000}"
                                         type="number"
                                         pattern="#,###"
                                     />đ
                                 </c:when>
                                 <c:otherwise>0đ</c:otherwise>
                             </c:choose>
                         </span>
                     </div>
                 </div>
 
                 <div class="space-y-4">
                     <button
                         type="button"
                         id="checkoutBtn"
                         class="w-full bg-primary text-primary-foreground py-3 rounded-md font-medium hover:bg-primary/90 disabled:opacity-50 disabled:cursor-not-allowed text-sm"
                         <c:if test="${cartCount == 0}">disabled</c:if>
                     >
                         Đặt hàng (${cartCount} sản phẩm)
                     </button>
 
                     <div class="text-center">
                         <a href="./home" class="text-sm text-muted-foreground hover:text-primary">
                             ← Tiếp tục mua sắm
                         </a>
                     </div>
                 </div>
             </div>
        </div>

        <!-- Thông báo -->
        <c:if test="${param.message == 'removed'}">
            <div class="fixed bottom-4 right-4 p-4 bg-green-100 border border-green-400 text-green-700 rounded-lg shadow-lg text-sm z-50 max-w-sm">
                <div class="flex items-center gap-2">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                    <span>Đã xóa sản phẩm khỏi giỏ hàng thành công!</span>
                </div>
            </div>
        </c:if>
        <c:if test="${param.error == 'remove_failed'}">
            <div class="fixed bottom-4 right-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg shadow-lg text-sm z-50 max-w-sm">
                <div class="flex items-center gap-2">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                    <span>Có lỗi xảy ra khi xóa sản phẩm. Vui lòng thử lại!</span>
                </div>
            </div>
        </c:if>
        <c:if test="${param.error == 'system_error'}">
            <div class="fixed bottom-4 right-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg shadow-lg text-sm z-50 max-w-sm">
                <div class="flex items-center gap-2">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                    </svg>
                    <span>Có lỗi hệ thống xảy ra. Vui lòng thử lại!</span>
                </div>
            </div>
        </c:if>
        
        <jsp:include page="../inc/footer.jsp" />
    </body>
</html>
