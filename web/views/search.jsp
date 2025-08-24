<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Tìm kiếm - ${searchQuery}</title>
        <link rel="icon" type="image/x-icon" href="icon-title.ico" />
        <link rel="stylesheet" href="./assets/css/globals.css" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../inc/home/header.jsp" />

        <div class="flex-1 w-full max-w-7xl mx-auto mt-24 pb-24 px-6">
            <!-- Header tìm kiếm -->
            <div class="mb-8">
                <div class="flex items-center gap-4">
                    <div class="text-sm text-muted-foreground">
                        Tìm thấy ${totalResults} sản phẩm
                    </div>
                </div>
            </div>

            <!-- Kết quả tìm kiếm -->
            <c:choose>
                <c:when test="${empty searchResults}">
                    <div class="text-center py-12">
                        <div class="text-6xl mb-4">🔍</div>
                        <h3 class="text-lg font-medium mb-2 text-sm">Không tìm thấy sản phẩm</h3>
                        <p class="text-muted-foreground mb-4 text-sm">
                            Không có sản phẩm nào phù hợp với từ khóa "${searchQuery}"
                        </p>
                        <a
                            href="./home"
                            class="inline-flex items-center px-4 py-2 bg-primary text-primary-foreground rounded-md hover:bg-primary/90 text-sm"
                        >
                            Quay về trang chủ
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Grid sản phẩm -->
                    <div
                        class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-6"
                    >
                        <c:forEach var="product" items="${searchResults}">
                            <div
                                class="bg-background rounded-lg shadow-sm hover:shadow-md transition-shadow"
                            >
                                <!-- Hình ảnh sản phẩm -->
                                <div class="aspect-square overflow-hidden rounded-t-lg">
                                    <img
                                        src="${product.image}"
                                        alt="${product.name}"
                                        class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                                    />
                                </div>

                                <!-- Thông tin sản phẩm -->
                                <div class="p-4">
                                    <h3 class="font-medium mb-2 text-sm line-clamp-2">
                                        ${product.name}
                                    </h3>

                                    <!-- Giá sản phẩm -->
                                    <div class="text-lg font-semibold text-primary mb-3 text-sm">
                                        <fmt:formatNumber
                                            value="${product.price}"
                                            type="number"
                                            pattern="#,###"
                                        />đ
                                    </div>

                                    <!-- Nút thêm vào giỏ hàng -->
                                    <form method="POST" action="add-to-cart" class="w-full">
                                        <input
                                            type="hidden"
                                            name="productId"
                                            value="${product.id}"
                                        />
                                        <input type="hidden" name="quantity" value="1" />
                                        <button
                                            type="submit"
                                            class="w-full bg-primary text-primary-foreground py-2 rounded-md font-medium hover:bg-primary/90 transition-colors text-sm"
                                        >
                                            Thêm vào giỏ hàng
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Thông báo lỗi -->
        <c:if test="${param.error == 'search_failed'}">
            <div
                class="fixed bottom-4 right-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg shadow-lg text-sm z-50 max-w-sm"
            >
                <div class="flex items-center gap-2">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path
                            fill-rule="evenodd"
                            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z"
                            clip-rule="evenodd"
                        ></path>
                    </svg>
                    <span>Có lỗi xảy ra khi tìm kiếm. Vui lòng thử lại!</span>
                </div>
            </div>
        </c:if>

        <jsp:include page="../inc/footer.jsp" />
    </body>
</html>
