<!-- MODERN NAVBAR -->
<!-- Modern Blog Navbar -->
<div class="header_section shadow-sm" style="background:#f8f9fa;">
    <div class="container-fluid header_main py-2">

        <nav class="navbar navbar-expand-lg navbar-light">

            <!-- LOGO / BRAND -->
            <a class="navbar-brand logo" href="index.jsp">
                <h1 style="color:#080c50; font-weight: bold; margin:0;">MY BLOGS</h1>
            </a>

            <!-- MOBILE TOGGLER -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarContent" aria-controls="navbarContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- NAV ITEMS -->
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto align-items-center">

                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="Dashboard.jsp">Feed</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="LogoutServlet">Logout</a>
                    </li>


                    

                    <li class="nav-item ms-2">
                        <a class="nav-link" href="#">
                            <img src="images/serach-icon.png" width="22" alt="search">
                        </a>
                    </li>

                </ul>
            </div>

        </nav>

    </div>
</div>


<style>
.nav-link {
    font-size: 16px;
    color: #333 !important;
    padding: 10px 18px !important;
}

.nav-link:hover {
    color: #080c50 !important;
}

.header_section {
    background: #f8f9fa;
}

.logo h1 {
    font-size: 28px;
}

</style>