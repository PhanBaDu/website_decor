<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Trang Đăng Nhập</title>
        <link rel="icon" type="image/x-icon" href="icon-title.ico" />
        <link rel="stylesheet" href="./assets/css/globals.css" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../inc/auth/header.jsp" />
        <div class="flex-1 w-full flex justify-center items-center mt-18">
            <form
                class="p-6 bg-card rounded-lg flex justify-center w-[400px] flex-col gap-4"
                method="post"
                action="login"
            >
                <h1 class="text-lg font-semibold text-center text-foreground">Đăng Nhập</h1>
                <% String error = (String) request.getAttribute("error"); %> <% if (error != null) {
                %>
                <div
                    class="text-destructive border border-destructive bg-red-500/10 rounded-lg p-4 text-xs"
                >
                    <%= error %>
                </div>
                <% } %>
                <div class="flex flex-col gap-2">
                    <label for="emailPhone" class="text-sm font-medium text-foreground">
                        Email
                    </label>
                    <input
                        name="emailPhone"
                        type="text"
                        placeholder="Nhập email hoặc số điện thoại của bạn...."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                        required
                    />
                </div>
                <div class="flex flex-col gap-2">
                    <label for="password" class="text-sm font-medium text-foreground">
                        Mật khẩu
                    </label>
                    <input
                        name="password"
                        type="password"
                        placeholder="Nhập mật khẩu của bạn...."
                        class="w-full h-9 px-3 py-1 text-sm bg-background border border-input rounded-md placeholder:text-muted-foreground outline-none"
                        required
                    />
                </div>
                <button
                    type="submit"
                    class="mt-4 text-sm px-4 py-2 bg-primary text-primary-foreground rounded-md font-medium hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-ring transition-all"
                >
                    Đăng nhập
                </button>
                <!-- Sign Up Link -->
                <div class="text-center text-xs">
                    <span class="text-secondary-foreground">Chưa có tài khoản? </span>
                    <a href="register" class="text-sky-600 font-medium hover:underline">
                        Đăng ký ngay
                    </a>
                </div>
            </form>
        </div>
        <jsp:include page="../inc/footer.jsp" />
    </body>
</html>
