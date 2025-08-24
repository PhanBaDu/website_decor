<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Tạo Sản Phẩm</title>
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
        <div class="flex-1 w-full flex justify-center items-center mt-18">
            <form
                class="p-6 bg-card rounded-lg flex justify-center w-[500px] flex-col gap-4"
                method="post"
                action="${pageContext.request.contextPath}/admin/newproduct"
            >
                <h1 class="text-lg font-semibold text-center text-foreground">Tạo Sản Phẩm Mới</h1>

                <c:if test="${not empty error}">
                    <div
                        class="text-destructive border border-destructive bg-red-500/10 rounded-lg p-4 text-xs"
                    >
                        ${error}
                    </div>
                </c:if>

                <div class="flex flex-col gap-2">
                    <label for="name" class="text-sm font-medium text-foreground">
                        Tên sản phẩm
                    </label>
                    <input
                        name="name"
                        id="name"
                        type="text"
                        placeholder="Nhập tên sản phẩm..."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                        required
                    />
                </div>

                <div class="flex flex-col gap-2">
                    <label for="image" class="text-sm font-medium text-foreground">
                        URL hình ảnh
                    </label>
                    <input
                        name="image"
                        id="image"
                        type="url"
                        placeholder="Nhập URL hình ảnh sản phẩm..."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                        required
                    />
                </div>

                <div class="flex flex-col gap-2">
                    <label for="price" class="text-sm font-medium text-foreground">
                        Giá (VNĐ)
                    </label>
                    <input
                        name="price"
                        id="price"
                        type="number"
                        min="0"
                        step="1000"
                        placeholder="Nhập giá sản phẩm..."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
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
                        placeholder="Nhập số lượng sản phẩm..."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                        required
                    />
                </div>

                <div class="flex flex-col gap-2">
                    <label for="idCategory" class="text-sm font-medium text-foreground">
                        Danh mục
                    </label>
                    <select
                        name="idCategory"
                        id="idCategory"
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md outline-none"
                        required
                    >
                        <option value="">Chọn danh mục</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}">${category.name}</option>
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
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md outline-none"
                        required
                    >
                        <option value="1">Hoạt động</option>
                        <option value="0">Không hoạt động</option>
                    </select>
                </div>

                <button
                    type="submit"
                    class="mt-4 text-sm px-4 py-2 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                >
                    Tạo sản phẩm
                </button>

                <!-- Back to products link -->
                <div class="text-center text-xs">
                    <a
                        href="${pageContext.request.contextPath}/admin/allproduct"
                        class="text-sky-600 font-medium hover:underline"
                    >
                        ← Quay lại danh sách sản phẩm
                    </a>
                </div>
            </form>
        </div>
        <jsp:include page="../../inc/footer.jsp" />
    </body>
</html>
