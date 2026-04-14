const log = document.getElementById('logInput')

log.addEventListener("change", function(e) {
    const file = e.target.files[0]; //input
    const reader = new FileReader();

    reader.onload = function(e) {
        const text = e.target.result; //actual contents
        document.getElementById("output").textContent = text;
    }

    reader.readAsText(file);
});

const now = new Date();
const month = now.getUTCMonth();

if ([0, 2, 4, 6, 7, 9, 11].includes(month))
    cells = 31
else if (month !== 1)
    cells = 30
else
    cells = 28

cols = 7
rows = 5
const grid = document.getElementById("grid")
grid.style.gridTemplateColumns = `repeat(${cols}, 40px)`
grid.style.gridTemplateRows = `repeat(${rows}, 40px)`

for (let i = 0; i < cells; i++) {
    const cell = document.createElement("div")
    cell.classList.add("cell")
    grid.appendChild(cell)
}
