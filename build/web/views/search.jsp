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
            <div class="mb-5">
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
                                <div class="relative aspect-square overflow-hidden rounded-t-lg">
                                    <img
                                        src="${product.image}"
                                        alt="${product.name}"
                                        class="w-full h-full object-cover hover:scale-105 transition-transform duration-300"
                                    />

                                    <!-- Status Badge -->
                                    <c:if test="${product.quantity <= 0}">
                                        <div
                                            class="absolute top-2 right-2 bg-red-500 text-white px-2 py-1 rounded-md text-xs font-bold"
                                        >
                                            Hết hàng
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Thông tin sản phẩm -->
                                <div class="p-4">
                                    <!-- Tên sản phẩm -->
                                    <h3
                                        class="font-semibold text-lg text-gray-800 mb-2 line-clamp-2 text-sm"
                                    >
                                        ${product.name}
                                    </h3>

                                    <!-- Giá sản phẩm -->
                                    <div class="mb-3 text-sm">
                                        <span class="font-bold text-primary">
                                            <fmt:formatNumber
                                                value="${product.price}"
                                                pattern="#,###"
                                            />₫
                                        </span>
                                    </div>

                                    <!-- Trạng thái sản phẩm -->
                                    <div class="flex justify-between items-baseline">
                                        <c:choose>
                                            <c:when test="${product.status}">
                                                <span
                                                    class="inline-flex items-center px-2 py-1 rounded-sm text-xs font-medium bg-green-100 text-green-800 mb-1"
                                                >
                                                    <span
                                                        class="w-2 h-2 mr-1 bg-green-400 rounded-full"
                                                    ></span>
                                                    Đang bán
                                                </span>
                                                <!-- Số lượng sản phẩm -->
                                                <div class="mb-3">
                                                    <c:choose>
                                                        <c:when test="${product.quantity > 0}">
                                                            <h1
                                                                class="text-primary font-bold text-xs"
                                                            >
                                                                Số lượng:
                                                                <span
                                                                    class="text-green-600 font-bold text-sm"
                                                                    >${product.quantity}</span
                                                                >
                                                            </h1>
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
                                            </c:when>
                                            <c:otherwise>
                                                <span
                                                    class="inline-flex mb-3 items-center px-2 py-1 rounded-sm text-xs font-medium bg-gray-100 text-gray-800"
                                                >
                                                    <span
                                                        class="w-2 h-2 mr-2 bg-gray-400 rounded-full"
                                                    ></span>
                                                    Ngừng bán
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="flex gap-2">
                                        <a
                                            href="${pageContext.request.contextPath}/product?id=${product.id}"
                                            class="flex-1 inline-flex justify-center bg-primary text-white text-center py-2 px-2 rounded-md hover:bg-primary/90 transition-colors text-sm font-medium"
                                        >
                                            Chi tiết sản phẩm
                                        </a>

                                        <c:if test="${product.quantity > 0 && product.status}">
                                            <form
                                                action="add-to-cart?action=newProductToCart"
                                                method="post"
                                            >
                                                <input
                                                    type="hidden"
                                                    name="id"
                                                    value="${product.id}"
                                                />
                                                <input
                                                    type="hidden"
                                                    name="price"
                                                    value="${product.price}"
                                                />
                                                <button
                                                    type="submit"
                                                    class="px-4 py-2.5 has-[>svg]:px-3 cursor-pointer border bg-background shadow-xs inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-xs font-medium [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none text-lg hover:bg-gray-50 transition-colors"
                                                >
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-badge-plus-icon lucide-badge-plus"><path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z"/><line x1="12" x2="12" y1="8" y2="16"/><line x1="8" x2="16" y1="12" y2="12"/></svg>
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
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
