const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const taxPriceElement = document.getElementById("add-tax-price");
      taxPriceElement.innerHTML = Math.floor(inputValue * 0.1);
    const profitElement = document.getElementById("profit");
      profitElement.innerHTML = Math.floor(inputValue - (inputValue * 0.1));
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);