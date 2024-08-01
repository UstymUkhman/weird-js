import { set_chars, compile } from "./main.zig";

const reader = new FileReader();

reader.onload = () => {
  input.value = reader.result;
  parse.removeAttribute("disabled");
};

reader.onerror = (error) => console.error(error);

const input = document.getElementById("input");
const output = document.getElementById("output");

input.addEventListener("input", () =>
  input.value.length
    ? parse.removeAttribute("disabled")
    : parse.setAttribute("disabled", "")
);

input.addEventListener("dragenter", () => input.classList.add("hover"));

input.addEventListener("drop", event => {
  event.preventDefault();
  input.classList.remove("hover");

  event.dataTransfer.files[0].type === "text/javascript" &&
    reader.readAsText(event.dataTransfer.files[0], "UTF-8");
});

input.addEventListener("dragleave", () => input.classList.remove("hover"));

const browse = document.getElementById("browse");
const parse = document.getElementById("parse");
const copy = document.getElementById("copy");
const download = document.getElementById("download");

browse.addEventListener("change", () => {
  browse.files.length && reader.readAsText(browse.files[0], "UTF-8");
});

parse.addEventListener("click", () => {
  const { string } = compile(input.value);
  output.textContent = string;

  copy.removeAttribute("disabled");
  download.removeAttribute("disabled");
});

copy.addEventListener("click", () =>
  navigator.clipboard.writeText(output.textContent)
);

download.addEventListener("click", () => {
  const file = new Blob([output.textContent], { type: "text/javascript" });
  download.href = URL.createObjectURL(file);
  URL.revokeObjectURL(file);
});

set_chars();
