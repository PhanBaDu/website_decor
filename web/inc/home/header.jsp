<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="${pageContext.request.requestURI}" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@page import="data.models.User"%>

<div class="p-4 w-full flex items-center justify-between gap-4 fixed bg-background z-50">
    <div class="flex-1 flex items-center gap-4">
        <a href="${pageContext.request.contextPath}">
            <img
                class="w-10"
                src="${pageContext.request.contextPath}/assets/images/logo.svg"
                alt="Logo"
            />
        </a>
        <% User user = (User) session.getAttribute("user"); %> <% if (user != null) { %>
        <div class="relative inline-flex text-left gap-4">
            <button
                type="button"
                class="justify-center text-sm font-medium w-44 text-primary cursor-pointer focus:outline-none bg-gray-100 p-2 rounded-lg border border-primary/50 font-semibold"
                id="userMenuButton"
            >
                Xin chào: <%= user.getName() %>
            </button>
            <button
                type="button"
                class="justify-center flex gap-2 w-44 text-sm font-medium text-background cursor-pointer focus:outline-none bg-primary p-2 rounded-lg border border-primary font-semibold [&_svg:not([class*='size-'])]:size-4 [&_svg]:shrink-0"
                id="userMenuButton"
            >
                <span>Admin</span>
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="lucide lucide-shield-user-icon lucide-shield-user"
                >
                    <path
                        d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"
                    />
                    <path d="M6.376 18.91a6 6 0 0 1 11.249.003" />
                    <circle cx="12" cy="11" r="4" />
                </svg>
            </button>
            <div
                id="userDropdown"
                class="hidden absolute left-0 mt-2 -bottom-20 w-40 bg-white border rounded-lg shadow-lg z-50"
            >
                <a href="profile" class="block px-4 py-2 text-sm text-foreground hover:bg-gray-100"
                    >Thông tin cá nhân</a
                >
                <a href="logout" class="block px-4 py-2 text-sm text-foreground hover:bg-gray-100"
                    >Đăng xuất</a
                >
            </div>
        </div>
        <% } else { %>
        <a
            href="login"
            class="text-primary underline-offset-4 hover:underline inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all"
        >
            Đăng nhập
        </a>
        <% } %>
    </div>

    <div class="flex-1 inline-flex gap-4 justify-center">
        <a
            class="${currentPage eq contextPath.concat('/home') ? 'text-background bg-primary border border-primary' : 'text-primary'} underline-offset-4 cursor-pointer inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none font-semibold px-3 py-2"
            href="home"
        >
            <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="lucide lucide-house"
            >
                <path d="M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8" />
                <path
                    d="M3 10a2 2 0 0 1 .709-1.528l7-5.999a2 2 0 0 1 2.582 0l7 5.999A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"
                />
            </svg>
            Home
        </a>

        <a
            class="${currentPage eq contextPath.concat('/shopping-cart') ? 'text-background bg-primary border border-primary' : 'text-primary'} underline-offset-4 cursor-pointer inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none font-semibold px-3 py-2"
            href="shopping-cart"
        >
            <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="lucide lucide-shopping-bag-icon lucide-shopping-bag"
            >
                <path d="M16 10a4 4 0 0 1-8 0" />
                <path d="M3.103 6.034h17.794" />
                <path
                    d="M3.4 5.467a2 2 0 0 0-.4 1.2V20a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6.667a2 2 0 0 0-.4-1.2l-2-2.667A2 2 0 0 0 17 2H7a2 2 0 0 0-1.6.8z"
                />
            </svg>
            Shopping Cart
        </a>

        <div class="relative inline-block text-left">
            <button
                type="button"
                class="text-primary underline-offset-4 inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none font-semibold cursor-pointer px-3 py-2"
                id="categoriesMenuButton"
            >
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="24"
                    height="24"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="lucide lucide-list-checks"
                >
                    <path d="m3 17 2 2 4-4" />
                    <path d="m3 7 2 2 4-4" />
                    <path d="M13 6h8" />
                    <path d="M13 12h8" />
                    <path d="M13 18h8" />
                </svg>
                Category
            </button>

            <ul
                id="categoriesDropdown"
                class="hidden absolute left-0 mt-2 w-48 bg-white border rounded-lg shadow-lg z-50 overflow-hidden"
            >
                <!-- "Tất cả danh mục" sẽ được thêm bằng JavaScript -->
                <c:forEach var="category" items="${listCategories}">
                    <li
                        class="px-2 py-2 hover:bg-gray-100 cursor-pointer category-item"
                        data-category-id="${category.getId()}"
                    >
                        <span
                            class="dropdown-item bg-green-100 border border-green-700 rounded-sm px-4 py-0.5 text-green-800 text-sm font-semibold ml-2"
                            ><c:out value="${category.name}"
                        /></span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="flex-1 flex justify-end items-center gap-4">
        <form action="${pageContext.request.contextPath}/search" method="GET" class="relative">
            <div class="relative">
                <svg
                    class="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-muted-foreground"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                >
                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                    />
                </svg>
                <input
                    type="text"
                    name="q"
                    id="searchInput"
                    placeholder="Tìm kiếm sản phẩm..."
                    class="file:text-foreground placeholder:text-muted-foreground selection:bg-primary selection:text-primary-foreground dark:bg-input/30 border-input flex h-9 w-full min-w-0 rounded-md border bg-transparent pl-10 pr-10 text-base shadow-xs transition-[color,box-shadow] outline-none file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm shadow-none"
                    autocomplete="off"
                />
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // User dropdown
        const userButton = document.getElementById('userMenuButton');
        const userDropdown = document.getElementById('userDropdown');

        if (userButton && userDropdown) {
            userButton.addEventListener('click', function (e) {
                e.stopPropagation();
                userDropdown.classList.toggle('hidden');
                // Đóng categories dropdown nếu đang mở
                const categoriesDropdown = document.getElementById('categoriesDropdown');
                if (categoriesDropdown && !categoriesDropdown.classList.contains('hidden')) {
                    categoriesDropdown.classList.add('hidden');
                }
            });
        }

        // Categories dropdown
        const categoriesButton = document.getElementById('categoriesMenuButton');
        const categoriesDropdown = document.getElementById('categoriesDropdown');

        if (categoriesButton && categoriesDropdown) {
            categoriesButton.addEventListener('click', function (e) {
                e.stopPropagation();
                categoriesDropdown.classList.toggle('hidden');
                // Đóng user dropdown nếu đang mở
                if (userDropdown && !userDropdown.classList.contains('hidden')) {
                    userDropdown.classList.add('hidden');
                }
            });
        }

        // Category filtering functionality
        // Thêm nút "Tất cả danh mục" vào đầu dropdown
        const showAllButton = document.createElement('li');
        showAllButton.className =
            'px-2 py-2 hover:bg-gray-100 cursor-pointer border-b border-gray-200';
        showAllButton.innerHTML = `
            <span class="dropdown-item bg-blue-100 border border-blue-700 rounded-sm px-4 py-0.5 text-blue-800 text-sm font-semibold ml-2">
                Tất cả danh mục
            </span>
        `;

        if (categoriesDropdown) {
            categoriesDropdown.insertBefore(showAllButton, categoriesDropdown.firstChild);
        }

        // Xử lý click "Tất cả danh mục"
        showAllButton.addEventListener('click', function () {
            showAllCategories();
            categoriesDropdown.classList.add('hidden');
        });

        // Xử lý click cho từng category
        const categoryItems = document.querySelectorAll('.category-item');
        categoryItems.forEach(function (item) {
            item.addEventListener('click', function () {
                const categoryText = item.querySelector('.dropdown-item').textContent.trim();
                const categoryId = item.getAttribute('data-category-id');
                filterByCategory(categoryText, categoryId);
                categoriesDropdown.classList.add('hidden');
            });
        });

        // Đóng dropdowns khi click outside
        document.addEventListener('click', function (e) {
            if (
                userDropdown &&
                !userButton?.contains(e.target) &&
                !userDropdown.contains(e.target)
            ) {
                userDropdown.classList.add('hidden');
            }
            if (
                categoriesDropdown &&
                !categoriesButton?.contains(e.target) &&
                !categoriesDropdown.contains(e.target)
            ) {
                categoriesDropdown.classList.add('hidden');
            }
        });

        // Đóng dropdowns khi nhấn Escape
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                if (userDropdown) userDropdown.classList.add('hidden');
                if (categoriesDropdown) categoriesDropdown.classList.add('hidden');
            }
        });
    });

    function showAllCategories() {
        // Hiển thị tất cả sections
        const sections = document.querySelectorAll('section[data-category-id]');
        sections.forEach(function (section) {
            section.style.display = 'block';
        });

        // Cập nhật title
        updatePageTitle('Tất cả danh mục');
    }

    function filterByCategory(categoryName, categoryId) {
        const sections = document.querySelectorAll('section[data-category-id]');

        sections.forEach(function (section) {
            const sectionCategoryId = section.getAttribute('data-category-id');
            if (sectionCategoryId === categoryId) {
                section.style.display = 'block';
            } else {
                section.style.display = 'none';
            }
        });
    }
</script>
