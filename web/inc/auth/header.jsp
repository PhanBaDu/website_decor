<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="p-4 w-full flex items-center justify-between gap-4 fixed bg-background z-50">
    <div class="flex-1">
        <a href="${pageContext.request.contextPath}">
            <img
                class="w-10"
                src="${pageContext.request.contextPath}/assets/images/logo.svg"
                alt="Logo"
            />
        </a>
    </div>
    <div class="flex-1 flex justify-end items-center gap-4">
        <a href="${pageContext.request.contextPath}">
            <button
                class="px-4 py-2 has-[>svg]:px-3 cursor-pointer border bg-background shadow-xs inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-xs font-medium [&_svg:not([class*='size-'])]:size-4 shrink-0 [&_svg]:shrink-0 outline-none text-sm"
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
                    class="lucide lucide-chevron-left-icon lucide-chevron-left"
                >
                    <path d="m15 18-6-6 6-6" />
                </svg>
                Trở về trang chủ
            </button>
        </a>
    </div>
</div>
