<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Cập Nhật Sản Phẩm</title>
        <link
            rel="icon"
            type="image/x-icon"
            href="${pageContext.request.contextPath}/icon-title.ico"
        />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/globals.css" />
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../../inc/admin/header.jsp" />
        <div class="flex-1 w-full flex justify-center items-center mt-24 pb-10">
            <form
                class="p-8 bg-card rounded-lg w-[800px] flex-col gap-6"
                method="post"
                action="admin/updateproduct"
                enctype="multipart/form-data"
            >
                <h1 class="text-xl font-semibold text-center text-foreground mb-6">
                    Cập Nhật Sản Phẩm
                </h1>

                <!-- Hiển thị lỗi nếu có -->
                <c:if test="${not empty error}">
                    <div
                        class="text-destructive border border-destructive bg-red-500/10 rounded-lg p-4 text-xs mb-6"
                    >
                        ${error}
                    </div>
                </c:if>

                <!-- Hidden input để lưu ID sản phẩm -->
                <input type="hidden" name="productId" value="${product.id}" />

                <!-- Row 1: Product Name and Image -->
                <div class="grid grid-cols-2 gap-6">
                    <div class="flex flex-col gap-2">
                        <label for="name" class="text-sm font-medium text-foreground">
                            Tên sản phẩm
                        </label>
                        <input
                            name="name"
                            id="name"
                            type="text"
                            value="${product.name}"
                            placeholder="Nhập tên sản phẩm..."
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                            required
                        />
                    </div>

                    <div class="flex flex-col gap-2">
                        <label for="image" class="text-sm font-medium text-foreground">
                            Hình ảnh sản phẩm
                        </label>
                        <input
                            name="image"
                            id="image"
                            type="file"
                            accept="image/*"
                            class="w-full inline-flex h-10 px-3 py-2 text-sm bg-background border border-input rounded-md file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-medium file:bg-primary file:text-primary-foreground hover:file:bg-primary/90"
                        />
                        <!-- Hiển thị ảnh hiện tại -->
                        <div class="mt-2">
                            <p class="text-xs text-muted-foreground mb-1">Ảnh hiện tại:</p>
                            <img 
                                src="${pageContext.request.contextPath}/${product.image}" 
                                alt="Current image" 
                                class="w-20 h-20 object-cover rounded border"
                            />
                        </div>
                    </div>
                </div>

                <!-- Row 2: Price and Quantity -->
                <div class="grid grid-cols-2 gap-6">
                    <div class="flex flex-col gap-2">
                        <label for="price" class="text-sm font-medium text-foreground">
                            Giá (VNĐ)
                        </label>
                        <input
                            name="price"
                            id="price"
                            type="text"
                            value="${product.price}"
                            placeholder="Nhập giá sản phẩm..."
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                            required
                        />
                    </div>

                    <div class="flex flex-col gap-2">
                        <label for="quantity" class="text-sm font-medium text-foreground">
                            Số lượng
                        </label>
                        <input
                            name="quantity"
                            id="quantity"
                            type="number"
                            min="0"
                            value="${product.quantity}"
                            placeholder="Nhập số lượng sản phẩm..."
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                            required
                        />
                    </div>
                </div>

                <!-- Row 3: Category and Status -->
                <div class="grid grid-cols-2 gap-6">
                    <div class="flex flex-col gap-2">
                        <label for="idCategory" class="text-sm font-medium text-foreground">
                            Danh mục
                        </label>
                        <select
                            name="idCategory"
                            id="idCategory"
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md outline-none"
                            required
                        >
                            <option value="">Chọn danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${category.id == product.idCategory ? 'selected' : ''}>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="flex flex-col gap-2">
                        <label for="status" class="text-sm font-medium text-foreground">
                            Trạng thái
                        </label>
                        <select
                            name="status"
                            id="status"
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md outline-none"
                            required
                        >
                            <option value="1" ${product.status ? 'selected' : ''}>Hoạt động</option>
                            <option value="0" ${!product.status ? 'selected' : ''}>Không hoạt động</option>
                        </select>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex justify-center gap-4 mt-8">
                    <button
                        type="submit"
                        class="px-8 py-3 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 transition-all text-sm"
                    >
                        Cập nhật sản phẩm
                    </button>
                    <a
                        href="${pageContext.request.contextPath}/admin/allproduct"
                        class="px-8 py-3 bg-gray-500 text-white rounded-md font-medium hover:bg-gray-600 transition-all text-sm"
                    >
                        Hủy
                    </a>
                </div>
            </form>
        </div>
        <jsp:include page="../../inc/footer.jsp" />
    </body>
</html>
