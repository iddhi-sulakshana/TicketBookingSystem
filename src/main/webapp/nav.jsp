  <link rel="shortcut icon" href="./assets/primary-images/icon.png" type="image/x-icon">
</head>
<body>
<!-- Uncomment this to display bootstrap breakpoints -->
<!-- <div class="breakpoint"></div> -->
<!-- nav -->
<div id="preload">
  <div id="loader"></div>
</div>
<script src="./js/preload.js"></script>
<div id="clonenav">.</div>
<header>
  <nav class="navbar navbar-expand-lg bg-dark navbar-dark" id="navbar">
    <div class="container-sm">
      <a class="animate-nav navbar-brand" href="./"><img class="logo-img" src="./assets/primary-images/logo.png" alt="ABC Movies"></a>
      <button class="animate-nav navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <i class="fa-light fa-bars"></i>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
        <ul class="navbar-nav mb-2 mb-lg-0" style="margin-right: 10rem;">
          <li class="animate-nav nav-item mx-2">
            <a class="nav-link active" aria-current="page" href="./">Home</a>
          </li>
          <li class="animate-nav nav-item mx-2">
            <a class="nav-link" href="./#upcoming">Upcoming</a>
          </li>
          <li class="animate-nav nav-item mx-2">
            <a class="nav-link" href="./AboutUs.jsp">About</a>
          </li>
        </ul>
        <a href="./login.jsp"><div class="animate-nav nav-item p-2">
          <i id="usericon" class="fa-light fa-user"></i>
        </div>
        </a>
      </div>
    </div>
    <div class="loading-bar"></div>
  </nav>
</header>
<!-- end nav -->