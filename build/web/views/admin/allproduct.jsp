<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Quản Lý Sản Phẩm</title>
        <link
            rel="icon"
            type="image/x-icon"
            href="${pageContext.request.contextPath}/icon-title.ico"
        />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/globals.css" />
        <script>
            // Hàm mở modal chỉnh sửa sản phẩm
            function openEditModal(productId, productName, productPrice, productQuantity, productStatus, productCategoryId, productImage) {
                // Hiển thị modal
                document.getElementById('editModal').classList.remove('hidden');
                
                // Điền dữ liệu vào form
                document.getElementById('editProductId').value = productId;
                document.getElementById('editName').value = productName;
                document.getElementById('editPrice').value = productPrice;
                document.getElementById('editQuantity').value = productQuantity;
                document.getElementById('editStatus').value = productStatus ? '1' : '0';
                document.getElementById('editCategory').value = productCategoryId;
                
                // Hiển thị ảnh hiện tại
                document.getElementById('currentImage').src = '${pageContext.request.contextPath}/' + productImage;
            }
            
            // Hàm đóng modal
            function closeEditModal() {
                document.getElementById('editModal').classList.add('hidden');
            }
            
            // Đóng modal khi click bên ngoài
            document.addEventListener('DOMContentLoaded', function () {
                const modal = document.getElementById('editModal');
                modal.addEventListener('click', function (e) {
                    if (e.target === modal) {
                        closeEditModal();
                    }
                });
            });
        </script>
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../../inc/admin/header.jsp" />
        <div class="flex-1 flex-col gap-4 w-full flex max-w-7xl mx-auto mt-24 pb-24">
            <!-- Success Message -->
            <c:if test="${param.success == 'updated'}">
                <div
                    class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-6"
                >
                    <div class="flex items-center">
                        <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path
                                fill-rule="evenodd"
                                d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                clip-rule="evenodd"
                            ></path>
                        </svg>
                        <span class="font-medium">Cập nhật sản phẩm thành công!</span>
                    </div>
                </div>
            </c:if>

            <!-- Products by Category -->
            <c:forEach var="category" items="${listCategories}">
                <section class="category-section" data-category-id="${category.getId()}">
                    <header class="w-full bg-background p-4 rounded-t-lg border-b border-gray-200">
                        <h3 class="font-semibold text-primary">
                            Danh mục:
                            <span
                                class="bg-blue-100 border border-blue-700 rounded-sm px-4 py-0.5 text-blue-800 text-sm font-semibold ml-2"
                                ><c:out value="${category.name}"
                            /></span>
                        </h3>
                    </header>
                    <div class="grid grid-cols-5 gap-4 p-4 bg-background rounded-b-lg">
                        <c:set var="hasProducts" value="false" />
                        <c:forEach var="product" items="${listProducts}">
                            <c:if test="${category.getId() == product.getIdCategory()}">
                                <c:set var="hasProducts" value="true" />
                                <div
                                    class="bg-white rounded-lg border overflow-hidden hover:shadow-lg transition-shadow"
                                >
                                    <!-- Product Image -->
                                    <div class="relative">
                                        <img
                                            class="rounded-t-lg overflow-hidden h-54 w-full object-cover"
                                            src="http://localhost:8686/website_decor/${product.getImage()}"
                                            alt="${product.getName()}"
                                        />

                                        <!-- Status Badge -->
                                        <c:if test="${product.getQuantity() <= 0}">
                                            <div
                                                class="absolute top-2 right-2 bg-red-500 text-white px-2 py-1 rounded-md text-xs font-bold"
                                            >
                                                Hết hàng
                                            </div>
                                        </c:if>
                                    </div>

                                    <!-- Product Info -->
                                    <div class="p-2 h-52 flex flex-col justify-between">
                                        <!-- Product Name -->
                                        <h3
                                            class="font-semibold text-lg text-gray-800 mb-2 line-clamp-2 text-sm"
                                        >
                                            ${product.getName()}
                                        </h3>

                                        <!-- Product Price -->
                                        <div class="mb-3 text-sm">
                                            <span class="font-bold text-primary">
                                                <fmt:formatNumber
                                                    value="${product.getPrice()}"
                                                    pattern="#,###"
                                                />₫
                                            </span>
                                        </div>

                                        <!-- Product Status -->
                                        <div class="flex justify-between items-baseline mb-3">
                                            <c:choose>
                                                <c:when test="${product.isStatus()}">
                                                    <span
                                                        class="inline-flex items-center px-2 py-1 rounded-sm text-xs font-medium bg-green-100 text-green-800"
                                                    >
                                                        <span
                                                            class="w-2 h-2 mr-1 bg-green-400 rounded-full"
                                                        ></span>
                                                        Đang bán
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span
                                                        class="inline-flex items-center px-2 py-1 rounded-sm text-xs font-medium bg-gray-100 text-gray-800"
                                                    >
                                                        <span
                                                            class="w-2 h-2 mr-2 bg-gray-400 rounded-full"
                                                        ></span>
                                                        Ngừng bán
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Product Quantity -->
                                        <div class="mb-3">
                                            <c:choose>
                                                <c:when test="${product.getQuantity() > 0}">
                                                    <span class="text-primary font-bold text-xs">
                                                        Số lượng:
                                                        <span
                                                            class="text-green-600 font-bold text-sm"
                                                            >${product.getQuantity()}</span
                                                        >
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span
                                                        class="text-red-600 text-xs font-semibold"
                                                    >
                                                        Hết hàng
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Edit Button - Mở modal -->
                                        <div class="flex gap-2">
                                            <button
                                                onclick="openEditModal(${product.getId()}, '${fn:replace(product.getName(), "'", "\\'")}', ${product.getPrice()}, ${product.getQuantity()}, ${product.isStatus()}, ${product.getIdCategory()}, '${product.getImage()}')"
                                                class="flex-1 inline-flex justify-center bg-primary text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors text-sm font-medium"
                                            >
                                                Chỉnh sửa
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>

                        <!-- Hiển thị thông báo nếu không có sản phẩm -->
                        <c:if test="${!hasProducts}">
                            <div class="col-span-5 text-center py-8 text-gray-500">
                                <svg
                                    class="mx-auto mb-4 w-16 h-16 text-gray-300"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
                                    ></path>
                                </svg>
                                <p class="text-lg font-medium">
                                    Chưa có sản phẩm nào trong danh mục này
                                </p>
                                <p class="text-sm">Hãy thêm sản phẩm mới vào danh mục này</p>
                            </div>
                        </c:if>
                    </div>
                </section>
            </c:forEach>
        </div>

        <!-- Modal chỉnh sửa sản phẩm -->
        <div
            id="editModal"
            class="hidden fixed inset-0 bg-gray-950/60 bg-opacity-50 flex items-center justify-center z-50"
        >
            <div class="bg-white rounded-lg p-6 w-full max-w-4xl max-h-[90vh] overflow-y-auto">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold">Chỉnh sửa sản phẩm</h2>
                    <button
                        onclick="closeEditModal()"
                        class="text-gray-500 hover:text-gray-700 text-2xl font-bold"
                    >
                        ×
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/updateproduct" method="POST" enctype="multipart/form-data">
                    <input type="hidden" id="editProductId" name="productId" />
                    
                    <!-- Row 1: Product Name and Image -->
                    <div class="grid grid-cols-2 gap-4 mb-4">
                        <div>
                            <label for="editName" class="block text-sm font-medium text-gray-700">Tên sản phẩm:</label>
                            <input type="text" id="editName" name="name" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required />
                        </div>
                        <div>
                            <label for="editImage" class="block text-sm font-medium text-gray-700">Hình ảnh mới (tùy chọn):</label>
                            <input type="file" id="editImage" name="image" accept="image/*" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" />
                            <!-- Hiển thị ảnh hiện tại -->
                            <div class="mt-2">
                                <p class="text-xs text-gray-500 mb-1">Ảnh hiện tại:</p>
                                <img id="currentImage" src="" alt="Current image" class="w-16 h-16 object-cover rounded border" />
                            </div>
                        </div>
                    </div>
                    
                    <!-- Row 2: Price and Quantity -->
                    <div class="grid grid-cols-2 gap-4 mb-4">
                        <div>
                            <label for="editPrice" class="block text-sm font-medium text-gray-700">Giá sản phẩm:</label>
                            <input type="number" id="editPrice" name="price" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required />
                        </div>
                        <div>
                            <label for="editQuantity" class="block text-sm font-medium text-gray-700">Số lượng:</label>
                            <input type="number" id="editQuantity" name="quantity" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required />
                        </div>
                    </div>
                    
                    <!-- Row 3: Category and Status -->
                    <div class="grid grid-cols-2 gap-4 mb-4">
                        <div>
                            <label for="editCategory" class="block text-sm font-medium text-gray-700">Danh mục:</label>
                            <select id="editCategory" name="idCategory" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required>
                                <option value="">Chọn danh mục</option>
                                <c:forEach var="category" items="${listCategories}">
                                    <option value="${category.getId()}">${category.getName()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label for="editStatus" class="block text-sm font-medium text-gray-700">Trạng thái:</label>
                            <select id="editStatus" name="status" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm" required>
                                <option value="1">Đang bán</option>
                                <option value="0">Ngừng bán</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="flex justify-end gap-2">
                        <button type="button" onclick="closeEditModal()" class="px-4 py-2 bg-gray-300 text-gray-700 rounded-md font-medium hover:bg-gray-400 transition-colors">Hủy</button>
                        <button type="submit" class="px-4 py-2 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 transition-colors">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="../../inc/footer.jsp" />
    </body>
</html>
