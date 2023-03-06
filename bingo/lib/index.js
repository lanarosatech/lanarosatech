const buttons = document.querySelectorAll(".clickable");
buttons.forEach((button) => {
  button.addEventListener('click', (event) => {
    // console.log(event.currentTarget);
    event.currentTarget.classList.toggle("active");
  });
});
