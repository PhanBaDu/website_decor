<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>HomeDecor - Trang Trí Nhà Cửa Đẹp & Hiện Đại</title>
        <link rel="icon" type="image/x-icon" href="icon-title.ico" />
        <link rel="stylesheet" href="./assets/css/globals.css" />
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            rel="stylesheet"
        />
        <style>
            .hero-section {
                background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
                min-height: 100vh;
                position: relative;
                overflow: hidden;
            }

            .hero-bg {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('./assets/images/background.png');
                background-size: cover;
                background-position: center;
                opacity: 0.1;
                z-index: 1;
            }

            .hero-content {
                position: relative;
                z-index: 2;
            }

            .gradient-text {
                background: linear-gradient(135deg, #1a1a1a 0%, #666666 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .card-hover {
                transition: all 0.3s ease;
            }

            .card-hover:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            }

            .feature-icon {
                width: 80px;
                height: 80px;
                background: linear-gradient(135deg, #1a1a1a 0%, #666666 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                color: white;
                font-size: 2rem;
            }

            .cta-section {
                background: linear-gradient(135deg, #1a1a1a 0%, #333333 100%);
                position: relative;
                overflow: hidden;
            }

            .cta-bg {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: url('./assets/images/decor1.png');
                background-size: cover;
                background-position: center;
                opacity: 0.1;
            }

            .feedback-card {
                background: white;
                border-radius: 20px;
                padding: 30px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                margin: 20px 0;
                border: 1px solid #e5e5e5;
            }

            .rating-stars {
                color: #fbbf24;
            }
        </style>
    </head>
    <body class="bg-background">
        <!-- Navigation -->
        <nav class="bg-background shadow-lg fixed w-full z-50 border-b border-border">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <div class="flex items-center">
                        <img
                            src="./assets/images/logo.svg"
                            alt="HomeDecor Logo"
                            class="h-8 w-auto"
                        />
                    </div>
                    <div class="hidden md:flex space-x-8">
                        <a
                            href="home"
                            class="text-foreground hover:text-muted-foreground transition-colors text-sm"
                            >Trang chủ</a
                        >
                        <a
                            href="#about"
                            class="text-foreground hover:text-muted-foreground transition-colors text-sm"
                            >Giới thiệu</a
                        >
                        <a
                            href="#feedback"
                            class="text-foreground hover:text-muted-foreground transition-colors text-sm"
                            >Đánh giá</a
                        >
                        <a
                            href="#contact"
                            class="text-foreground hover:text-muted-foreground transition-colors text-sm"
                            >Liên hệ</a
                        >
                    </div>
                    <div class="flex items-center space-x-4">
                        <a
                            href="login"
                            class="text-foreground hover:text-muted-foreground transition-colors text-sm"
                            >Đăng nhập</a
                        >
                        <a
                            href="register"
                            class="bg-foreground text-background px-4 py-2 rounded-full hover:bg-muted-foreground transition-all text-sm"
                            >Đăng ký</a
                        >
                    </div>
                </div>
            </div>
        </nav>

        <!-- Hero Section -->
        <section id="home" class="hero-section flex items-center justify-center">
            <div class="hero-bg"></div>
            <div class="hero-content text-center text-background max-w-4xl mx-auto px-4">
                <h1 class="text-4xl md:text-6xl font-black mb-6">
                    Biến Ngôi Nhà Thành<br />
                    <span class="text-muted-foreground">Tác Phẩm Nghệ Thuật</span>
                </h1>
                <p class="text-lg md:text-xl mb-8 text-muted-foreground max-w-3xl mx-auto">
                    Khám phá bộ sưu tập đồ trang trí nhà cửa độc đáo, hiện đại và chất lượng cao.
                    Tạo không gian sống đẹp mắt và ấm cúng cho gia đình bạn.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a
                        href="home"
                        class="bg-background text-foreground px-6 py-3 rounded-full text-base font-semibold hover:bg-muted transition-all transform hover:scale-105"
                    >
                        <i class="fas fa-shopping-cart mr-2"></i>Mua sắm ngay
                    </a>
                    <a
                        href="#about"
                        class="border-2 border-background text-background px-6 py-3 rounded-full text-base font-semibold hover:bg-background hover:text-foreground transition-all transform hover:scale-105"
                    >
                        <i class="fas fa-info-circle mr-2"></i>Tìm hiểu thêm
                    </a>
                </div>
            </div>
        </section>

        <!-- About Section -->
        <section id="about" class="py-20 bg-card">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6 text-foreground">
                        Về HomeDecor
                    </h2>
                    <p class="text-lg text-muted-foreground max-w-3xl mx-auto">
                        Chúng tôi là thương hiệu hàng đầu trong lĩnh vực trang trí nhà cửa, mang đến
                        những sản phẩm chất lượng cao với thiết kế độc đáo và hiện đại.
                    </p>
                </div>

                <div class="grid md:grid-cols-2 gap-12 items-center">
                    <div class="space-y-6">
                        <div
                            class="bg-background rounded-2xl p-8 shadow-lg card-hover border border-border"
                        >
                            <div class="feature-icon">
                                <i class="fas fa-palette"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-4 text-center text-foreground">
                                Thiết Kế Độc Đáo
                            </h3>
                            <p class="text-sm text-muted-foreground text-center">
                                Mỗi sản phẩm đều được thiết kế độc đáo, phù hợp với xu hướng hiện
                                đại và mang lại vẻ đẹp tinh tế cho không gian sống.
                            </p>
                        </div>

                        <div
                            class="bg-background rounded-2xl p-8 shadow-lg card-hover border border-border"
                        >
                            <div class="feature-icon">
                                <i class="fas fa-award"></i>
                            </div>
                            <h3 class="text-xl font-bold mb-4 text-center text-foreground">
                                Chất Lượng Cao
                            </h3>
                            <p class="text-sm text-muted-foreground text-center">
                                Sử dụng nguyên liệu cao cấp, quy trình sản xuất nghiêm ngặt để đảm
                                bảo chất lượng tốt nhất cho mọi sản phẩm.
                            </p>
                        </div>
                    </div>

                    <div class="relative">
                        <img
                            src="./assets/images/gioithieu1.jpg"
                            alt="Về chúng tôi"
                            class="rounded-2xl shadow-2xl"
                        />
                        <div
                            class="absolute -bottom-6 -left-6 bg-background p-6 rounded-2xl shadow-lg border border-border"
                        >
                            <div class="text-center">
                                <div class="text-2xl font-bold text-foreground">500+</div>
                                <div class="text-sm text-muted-foreground">Sản phẩm đa dạng</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Customer Feedback Section -->
        <section id="feedback" class="py-20 bg-muted">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6 text-foreground">
                        Khách Hàng Nói Gì?
                    </h2>
                    <p class="text-lg text-muted-foreground max-w-3xl mx-auto">
                        Những đánh giá chân thực từ khách hàng đã tin tưởng và sử dụng sản phẩm của
                        HomeDecor
                    </p>
                </div>

                <div class="grid md:grid-cols-3 gap-8">
                    <div class="feedback-card card-hover">
                        <div class="flex items-center mb-4">
                            <div
                                class="w-12 h-12 bg-foreground rounded-full flex items-center justify-center text-background font-bold"
                            >
                                N
                            </div>
                            <div class="ml-4">
                                <h4 class="font-bold text-foreground text-sm">Nguyễn Thị Anh</h4>
                                <p class="text-muted-foreground text-xs">Hà Nội</p>
                            </div>
                        </div>
                        <p class="text-foreground mb-4 text-sm">
                            "Sản phẩm chất lượng rất tốt, giao hàng nhanh chóng. Phòng khách nhà tôi
                            giờ đẹp hơn rất nhiều! Tôi rất hài lòng với dịch vụ."
                        </p>
                        <div class="flex rating-stars mb-4">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <a
                            href="home"
                            class="inline-block bg-foreground text-background px-3 py-1.5 rounded-full text-xs font-semibold hover:bg-muted-foreground transition-all"
                        >
                            <i class="fas fa-shopping-cart mr-1"></i>Mua sắm ngay
                        </a>
                    </div>

                    <div class="feedback-card card-hover">
                        <div class="flex items-center mb-4">
                            <div
                                class="w-12 h-12 bg-foreground rounded-full flex items-center justify-center text-background font-bold"
                            >
                                T
                            </div>
                            <div class="ml-4">
                                <h4 class="font-bold text-foreground text-sm">Trần Văn Bình</h4>
                                <p class="text-muted-foreground text-xs">TP.HCM</p>
                            </div>
                        </div>
                        <p class="text-foreground mb-4 text-sm">
                            "Thiết kế rất hiện đại và độc đáo. Dịch vụ khách hàng rất tốt, tư vấn
                            nhiệt tình. Sẽ tiếp tục ủng hộ HomeDecor!"
                        </p>
                        <div class="flex rating-stars mb-4">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <a
                            href="home"
                            class="inline-block bg-foreground text-background px-3 py-1.5 rounded-full text-xs font-semibold hover:bg-muted-foreground transition-all"
                        >
                            <i class="fas fa-shopping-cart mr-1"></i>Mua sắm ngay
                        </a>
                    </div>

                    <div class="feedback-card card-hover">
                        <div class="flex items-center mb-4">
                            <div
                                class="w-12 h-12 bg-foreground rounded-full flex items-center justify-center text-background font-bold"
                            >
                                L
                            </div>
                            <div class="ml-4">
                                <h4 class="font-bold text-foreground text-sm">Lê Thị Cẩm</h4>
                                <p class="text-muted-foreground text-xs">Đà Nẵng</p>
                            </div>
                        </div>
                        <p class="text-foreground mb-4 text-sm">
                            "Giá cả hợp lý, chất lượng vượt trội. Đóng gói cẩn thận, giao hàng đúng
                            hẹn. Tôi rất thích các sản phẩm trang trí phòng ngủ."
                        </p>
                        <div class="flex rating-stars mb-4">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <a
                            href="home"
                            class="inline-block bg-foreground text-background px-3 py-1.5 rounded-full text-xs font-semibold hover:bg-muted-foreground transition-all"
                        >
                            <i class="fas fa-shopping-cart mr-1"></i>Mua sắm ngay
                        </a>
                    </div>
                </div>

                <div class="text-center mt-12">
                    <a
                        href="home"
                        class="bg-foreground text-background px-6 py-3 rounded-full text-base font-semibold hover:bg-muted-foreground transition-all transform hover:scale-105"
                    >
                        <i class="fas fa-eye mr-2"></i>Xem tất cả sản phẩm
                    </a>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-20 bg-background">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6 text-foreground">
                        Tại Sao Chọn HomeDecor?
                    </h2>
                </div>

                <div class="grid md:grid-cols-4 gap-8">
                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-4">
                            <i class="fas fa-shipping-fast"></i>
                        </div>
                        <h3 class="text-lg font-bold mb-2 text-foreground">Giao Hàng Nhanh</h3>
                        <p class="text-sm text-muted-foreground">
                            Giao hàng toàn quốc trong 24-48h
                        </p>
                    </div>

                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-4">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3 class="text-lg font-bold mb-2 text-foreground">Bảo Hành Chính Hãng</h3>
                        <p class="text-sm text-muted-foreground">
                            Bảo hành 12 tháng cho mọi sản phẩm
                        </p>
                    </div>

                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-4">
                            <i class="fas fa-undo"></i>
                        </div>
                        <h3 class="text-lg font-bold mb-2 text-foreground">Đổi Trả Dễ Dàng</h3>
                        <p class="text-sm text-muted-foreground">Đổi trả miễn phí trong 30 ngày</p>
                    </div>

                    <div class="text-center">
                        <div class="feature-icon mx-auto mb-4">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h3 class="text-lg font-bold mb-2 text-foreground">Hỗ Trợ 24/7</h3>
                        <p class="text-sm text-muted-foreground">Tư vấn và hỗ trợ khách hàng</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section py-20 text-background relative">
            <div class="cta-bg"></div>
            <div class="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <h2 class="text-3xl md:text-4xl font-bold mb-6">
                    Sẵn Sàng Biến Đổi Không Gian Sống?
                </h2>
                <p class="text-lg mb-8 text-muted-foreground max-w-3xl mx-auto">
                    Tham gia cùng hàng nghìn khách hàng đã tin tưởng HomeDecor để tạo nên không gian
                    sống đẹp mắt và ấm cúng.
                </p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a
                        href="register"
                        class="bg-background text-foreground px-6 py-3 rounded-full text-base font-semibold hover:bg-muted transition-all transform hover:scale-105"
                    >
                        <i class="fas fa-user-plus mr-2"></i>Đăng ký ngay
                    </a>
                    <a
                        href="home"
                        class="border-2 border-background text-background px-6 py-3 rounded-full text-base font-semibold hover:bg-background hover:text-foreground transition-all transform hover:scale-105"
                    >
                        <i class="fas fa-shopping-bag mr-2"></i>Mua sắm ngay
                    </a>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer id="contact" class="bg-foreground text-background py-16">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid md:grid-cols-4 gap-8">
                    <div>
                        <div class="flex items-center mb-4">
                            <img
                                src="./assets/images/logo.svg"
                                alt="HomeDecor Logo"
                                class="h-8 w-auto"
                            />
                            <span class="ml-2 text-lg font-bold text-background">HomeDecor</span>
                        </div>
                        <p class="text-muted-foreground mb-4 text-sm">
                            Thương hiệu hàng đầu trong lĩnh vực trang trí nhà cửa, mang đến những
                            sản phẩm chất lượng cao với thiết kế độc đáo.
                        </p>
                        <div class="flex space-x-4">
                            <a
                                href="#"
                                class="w-10 h-10 bg-muted-foreground rounded-full flex items-center justify-center text-background hover:scale-110 transition-all"
                            >
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a
                                href="#"
                                class="w-10 h-10 bg-muted-foreground rounded-full flex items-center justify-center text-background hover:scale-110 transition-all"
                            >
                                <i class="fab fa-instagram"></i>
                            </a>
                            <a
                                href="#"
                                class="w-10 h-10 bg-muted-foreground rounded-full flex items-center justify-center text-background hover:scale-110 transition-all"
                            >
                                <i class="fab fa-youtube"></i>
                            </a>
                        </div>
                    </div>

                    <div>
                        <h3 class="text-lg font-bold mb-4 text-background">Sản Phẩm</h3>
                        <ul class="space-y-2 text-muted-foreground text-sm">
                            <li>
                                <a href="home" class="hover:text-background transition-colors"
                                    >Đồ trang trí phòng khách</a
                                >
                            </li>
                            <li>
                                <a href="home" class="hover:text-background transition-colors"
                                    >Đồ trang trí phòng ngủ</a
                                >
                            </li>
                            <li>
                                <a href="home" class="hover:text-background transition-colors"
                                    >Đồ trang trí phòng bếp</a
                                >
                            </li>
                            <li>
                                <a href="home" class="hover:text-background transition-colors"
                                    >Đồ trang trí phòng tắm</a
                                >
                            </li>
                        </ul>
                    </div>

                    <div>
                        <h3 class="text-lg font-bold mb-4 text-background">Hỗ Trợ</h3>
                        <ul class="space-y-2 text-muted-foreground text-sm">
                            <li>
                                <a href="#" class="hover:text-background transition-colors"
                                    >Hướng dẫn mua hàng</a
                                >
                            </li>
                            <li>
                                <a href="#" class="hover:text-background transition-colors"
                                    >Chính sách đổi trả</a
                                >
                            </li>
                            <li>
                                <a href="#" class="hover:text-background transition-colors"
                                    >Bảo hành sản phẩm</a
                                >
                            </li>
                            <li>
                                <a href="#" class="hover:text-background transition-colors">FAQ</a>
                            </li>
                        </ul>
                    </div>

                    <div>
                        <h3 class="text-lg font-bold mb-4 text-background">Liên Hệ</h3>
                        <div class="space-y-2 text-muted-foreground text-sm">
                            <p>
                                <i class="fas fa-map-marker-alt mr-2"></i>123 Đường ABC, Quận 1,
                                TP.HCM
                            </p>
                            <p><i class="fas fa-phone mr-2"></i>1900 1234</p>
                            <p><i class="fas fa-envelope mr-2"></i>info@homedecor.vn</p>
                            <p><i class="fas fa-clock mr-2"></i>8:00 - 22:00 (T2-CN)</p>
                        </div>
                    </div>
                </div>

                <div
                    class="border-t border-muted-foreground mt-12 pt-8 text-center text-muted-foreground"
                >
                    <p>&copy; 2024 HomeDecor. Tất cả quyền được bảo lưu.</p>
                </div>
            </div>
        </footer>

        <script>
            // Smooth scrolling for navigation links
            document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start',
                        });
                    }
                });
            });

            // Add scroll effect to navigation
            window.addEventListener('scroll', function () {
                const nav = document.querySelector('nav');
                if (window.scrollY > 100) {
                    nav.classList.add('bg-background/95', 'backdrop-blur-sm');
                } else {
                    nav.classList.remove('bg-background/95', 'backdrop-blur-sm');
                }
            });
        </script>
    </body>
</html>
