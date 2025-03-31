const price = () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const taxPrice = Math.floor(inputValue * 0.1);
    document.getElementById("add-tax-price").innerHTML = taxPrice;
    const profit = inputValue - taxPrice;
    document.getElementById("profit").innerHTML = profit;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);