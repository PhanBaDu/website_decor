<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="${pageContext.request.requestURI}" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@page import="data.models.User"%>

<div class="p-4 w-full flex items-center justify-between gap-4 fixed bg-background z-50">
    <div class="flex-1 flex items-center gap-4">
        <a href="${pageContext.request.contextPath}/home">
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
            <div
                id="userDropdown"
                class="hidden absolute left-0 mt-2 -bottom-12 w-40 bg-white border rounded-lg shadow-lg z-50 overflow-hidden"
            >
                <a href="http://localhost:8686/website_decor/logout" class="block px-4 py-2 text-sm text-foreground hover:bg-gray-100"
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

    <div class="flex-1 inline-flex gap-4 justify-end">
        <a
            class="${currentPage eq contextPath.concat('/admin/newproduct') ? 'text-background bg-primary border border-primary' : 'text-primary'} w-40 underline-offset-4 cursor-pointer inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none font-semibold px-3 py-2"
            href="${pageContext.request.contextPath}/admin/newproduct"
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
                class="lucide lucide-plus"
            >
                <path d="M5 12h14" />
                <path d="M12 5v14" />
            </svg>
            Thêm sản phẩm
        </a>

        <a
            class="${currentPage eq contextPath.concat('/admin/allproduct') ? 'text-background bg-primary border border-primary' : 'text-primary'} w-40 underline-offset-4 cursor-pointer inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none font-semibold px-3 py-2"
            href="${pageContext.request.contextPath}/admin/allproduct"
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
                class="lucide lucide-package"
            >
                <path d="m7.5 4.27 9 5.15" />
                <path
                    d="M21 8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16Z"
                />
                <path d="m3.3 7 8.7 5 8.7-5" />
                <path d="M12 22V12" />
            </svg>
            Tất cả sản phẩm
        </a>

        <a
            class="${currentPage eq contextPath.concat('/admin/order') ? 'text-background bg-primary border border-primary' : 'text-primary'} w-40 underline-offset-4 cursor-pointer inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none font-semibold px-3 py-2"
            href="${pageContext.request.contextPath}/admin/order"
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
                class="lucide lucide-shopping-cart"
            >
                <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z" />
                <path d="M3 6h18" />
                <path d="M16 10a4 4 0 0 1-8 0" />
            </svg>
            Đơn hàng
        </a>
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
            });
        }

        // Đóng dropdowns khi click outside
        document.addEventListener('click', function (e) {
            if (
                userDropdown &&
                !userButton?.contains(e.target) &&
                !userDropdown.contains(e.target)
            ) {
                userDropdown.classList.add('hidden');
            }
        });

        // Đóng dropdowns khi nhấn Escape
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                if (userDropdown) userDropdown.classList.add('hidden');
            }
        });
    });
</script>