window.addEventListener('load', function(){

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const valueResult = inputValue * 0.1;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitNumber = document.getElementById("profit");
    addTaxDom.innerHTML = (Math.floor(valueResult));
    profitNumber.innerHTML = (Math.floor(inputValue - valueResult));
 })
})