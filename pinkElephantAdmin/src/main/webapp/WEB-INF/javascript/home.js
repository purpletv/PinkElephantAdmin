$(document).ready(function () {
    var slides = $('.slide');
    var currentSlide = 0;

    // Function to show the current slide
    function showSlide() {
	    // Hide all slides
	    slides.removeClass('active');
	    // Show the current slide
	    slides.eq(currentSlide).addClass('active');
	    // Update dots
	    updateDots();
	}


    // Function to move to the next slide
    function nextSlide() {
        currentSlide++;
        if (currentSlide >= slides.length) {
            currentSlide = 0;
        }
        showSlide();
        // Call nextSlide after 3 seconds
        setTimeout(nextSlide, 3000);
    }

   // Function to create sliding dots
function createDots() {
    var dotsContainer = document.getElementById('slideDots');
    for (var i = 0; i < slides.length; i++) {
        var dot = document.createElement('span');
        dot.className = 'dot';
        dot.setAttribute('data-slide', i);
        dot.onclick = function () {
            currentSlide = parseInt(this.getAttribute('data-slide'));
            showSlide();
        };
        dotsContainer.appendChild(dot);
    }
    updateDots();
}

// Function to update sliding dots based on the current slide
function updateDots() {
    var dots = document.getElementsByClassName('dot');
    for (var i = 0; i < dots.length; i++) {
        dots[i].classList.remove('activeDot');
    }
    dots[currentSlide].classList.add('activeDot');
}


    // Start the slideshow
    nextSlide();
    // Create dots after starting the slideshow
    createDots();
});