<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Giỏ Hàng</title>
        <link rel="icon" type="image/x-icon" href="icon-title.ico" />
        <link rel="stylesheet" href="./assets/css/globals.css" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    </head>
    <body class="bg-muted min-h-screen flex flex-col justify-between">
        <jsp:include page="../inc/home/header.jsp" />
        <div class="flex-1 w-full flex max-w-7xl mx-auto mt-24 pb-24 flex gap-6">
            <div class="w-3/5 bg-background p-4 rounded-lg flex flex-col gap-4">
                <c:forEach var="cartItem" items="${cartItems}">
                    <div class="w-full p-4 border rounded-sm">
                        <div class="h-24 flex gap-4">
                            <img
                                class="rounded-lg overflow-hidden h-full w-24 object-cover"
                                src="${cartItem.product.getImage()}"
                                alt="${cartItem.product.getName()}"
                            />
                            <span class="text-sm font-medium">${cartItem.product.getName()}</span>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="w-2/5 bg-background p-4 rounded-lg"></div>
        </div>
        <jsp:include page="../inc/footer.jsp" />
    </body>
</html>
