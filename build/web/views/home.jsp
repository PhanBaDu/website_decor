<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Trang Chính</title>
        <link rel="icon" type="image/x-icon" href="icon-title.ico" />
        <link rel="stylesheet" href="./assets/css/globals.css" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../inc/home/header.jsp" />
        <div class="flex-1 flex-col gap-4 w-full flex max-w-7xl mx-auto mt-24 pb-24">
            <c:forEach var="category" items="${listCategories}">
                <section class="category-section" data-category-id="${category.getId()}">
                    <header class="w-full bg-background p-4 rounded-t-lg border-b border-gray-200">
                        <h3 class="font-semibold text-primary">
                            Nhóm sản phẩm:
                            <span
                                class="bg-green-100 border border-green-700 rounded-sm px-4 py-0.5 text-green-800 text-sm font-semibold ml-2"
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
                                            src="${product.getImage()}"
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
                                    <div class="p-2">
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
                                        <div class="flex justify-between items-baseline">
                                            <c:choose>
                                                <c:when test="${product.isStatus()}">
                                                    <span
                                                        class="inline-flex items-center px-2 py-1 rounded-sm text-xs font-medium bg-green-100 text-green-800 mb-1"
                                                    >
                                                        <span
                                                            class="w-2 h-2 mr-1 bg-green-400 rounded-full"
                                                        ></span>
                                                        Đang bán
                                                    </span>
                                                    <!-- Product Quantity -->
                                                    <div class="mb-3">
                                                        <c:choose>
                                                            <c:when
                                                                test="${product.getQuantity() > 0}"
                                                            >
                                                                <h1
                                                                    class="text-primary font-bold text-xs"
                                                                >
                                                                    Số lượng:
                                                                    <span
                                                                        class="text-green-600 font-bold text-sm"
                                                                        >${product.getQuantity()}</span
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
                                                href="${pageContext.request.contextPath}/product?id=${product.getId()}"
                                                class="flex-1 inline-flex justify-center bg-primary text-white text-center py-2 px-4 rounded-md hover:bg-primary/90 transition-colors text-sm font-medium"
                                            >
                                                Chi tiết sản phẩm
                                            </a>

                                            <c:if
                                                test="${product.getQuantity() > 0 && product.isStatus()}"
                                            >
                                                <button
                                                    class="px-4 py-2 has-[>svg]:px-3 cursor-pointer border bg-background shadow-xs inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-xs font-medium [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none text-lg hover:bg-gray-50 transition-colors"
                                                >
                                                    <svg
                                                        xmlns="http://www.w3.org/2000/svg"
                                                        width="30"
                                                        height="30"
                                                        viewBox="0 0 24 24"
                                                        fill="none"
                                                        stroke="currentColor"
                                                        stroke-width="2"
                                                        stroke-linecap="round"
                                                        stroke-linejoin="round"
                                                        class="lucide lucide-badge-plus-icon lucide-badge-plus"
                                                    >
                                                        <path
                                                            d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z"
                                                        />
                                                        <line x1="12" x2="12" y1="8" y2="16" />
                                                        <line x1="8" x2="16" y1="12" y2="12" />
                                                    </svg>
                                                </button>
                                            </c:if>
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
                                <p class="text-sm">
                                    Vui lòng quay lại sau hoặc xem các danh mục khác
                                </p>
                            </div>
                        </c:if>
                    </div>
                </section>
            </c:forEach>
        </div>
        <jsp:include page="../inc/footer.jsp" />
    </body>
</html>
