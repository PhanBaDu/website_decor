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
        <script>
            // Only show/hide the new category input. No validation.
            function toggleCategoryInput() {
                const categorySelect = document.getElementById('categorySelect');
                const newCategoryDiv = document.getElementById('newCategoryDiv');
                if (categorySelect.value === 'new') {
                    newCategoryDiv.classList.remove('hidden');
                } else {
                    newCategoryDiv.classList.add('hidden');
                }
            }
            document.addEventListener('DOMContentLoaded', function () {
                toggleCategoryInput();
            });
        </script>
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../../inc/admin/header.jsp" />
        <div class="flex-1 w-full flex justify-center items-center mt-24 pb-10">
            <form
                class="p-8 bg-card rounded-lg w-[800px] flex-col gap-6"
                method="post"
                action="${pageContext.request.contextPath}/admin/newproduct"
                enctype="multipart/form-data"
            >
                <h1 class="text-xl font-semibold text-center text-foreground mb-6">
                    Tạo Sản Phẩm Mới
                </h1>

                <c:if test="${not empty error}">
                    <div
                        class="text-destructive border border-destructive bg-red-500/10 rounded-lg p-4 text-xs mb-6"
                    >
                        ${error}
                    </div>
                </c:if>

                <div class="grid grid-cols-2 gap-6">
                    <div class="flex flex-col gap-2">
                        <label for="name" class="text-sm font-medium text-foreground">
                            Tên sản phẩm
                        </label>
                        <input
                            name="name"
                            id="name"
                            type="text"
                            placeholder="Nhập tên sản phẩm..."
                            class="w-full h-10 px-3 py-2 outline-none text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
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
                            class="w-full inline-flex h-10 outline-none px-3 py-2 text-sm bg-background border border-input rounded-md outline-none file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:font-medium file:bg-primary file:text-primary-foreground hover:file:bg-primary/90"
                            required
                        />
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-6 mt-4">
                    <div class="flex flex-col gap-2">
                        <label for="price" class="text-sm font-medium text-foreground">
                            Giá (VNĐ)
                        </label>
                        <input
                            name="price"
                            id="price"
                            type="text"
                            placeholder="Nhập giá sản phẩm..."
                            class="w-full h-10 px-3 py-2 outline-none text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
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
                            class="w-full outline-none h-10 px-3 py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                            required
                        />
                    </div>
                </div>

                <div class="grid grid-cols-2 gap-6 mt-4">
                    <div class="flex flex-col gap-2">
                        <label for="categorySelect" class="text-sm font-medium text-foreground">
                            Danh mục
                        </label>
                        <select
                            id="categorySelect"
                            name="idCategory"
                            onchange="toggleCategoryInput()"
                            class="w-full h-10 px-3 py-2 text-sm bg-background border border-input rounded-md outline-none"
                            required
                        >
                            <option value="">Chọn danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                            <option value="new">+ Tạo danh mục mới</option>
                        </select>

                        <div id="newCategoryDiv" class="hidden mt-2">
                            <input
                                name="newCategoryName"
                                id="newCategoryName"
                                type="text"
                                placeholder="Nhập tên danh mục mới..."
                                class="w-full h-10 px-3 outline-none py-2 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground transition-colors"
                            />
                        </div>
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
                            <option value="1">Hoạt động</option>
                            <option value="0">Không hoạt động</option>
                        </select>
                    </div>
                </div>

                <div class="flex justify-center mt-8">
                    <button
                        type="submit"
                        class="px-8 py-3 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 transition-all text-sm"
                    >
                        Tạo sản phẩm
                    </button>
                </div>

                <div class="text-center text-xs mt-4">
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
