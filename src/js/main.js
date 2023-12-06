const mathjs = require('mathjs')

/** @type {HTMLHeadingElement} */
let result_header = document.getElementById("res");


let clear_btn = document.getElementById("clr");

/** @type {string} */
let math_eval = "";
let output = "";

/** @type {number} */
const max_eval_len = 13;

clear_btn.onclick = () => {
    math_eval = "";
    output = "";
}


/** @type {Object.<string, HTMLButtonElement>} */
let number_buttons = {
    zero: document.getElementById("num0"),
    one: document.getElementById("num1"),
    two: document.getElementById("num2"),
    three: document.getElementById("num3"),
    four: document.getElementById("num4"),
    five: document.getElementById("num5"),
    six: document.getElementById("num6"),
    seven: document.getElementById("num7"),
    eight: document.getElementById("num8"),
    nine: document.getElementById("num9"),
    dot: document.getElementById("dot")
};
 
number_buttons.zero.onclick = () => { math_eval += '0'; output += '0'; }
number_buttons.one.onclick = () => { math_eval += '1';  output += '1'; }
number_buttons.two.onclick = () => { math_eval += '2';  output += '2'; }
number_buttons.three.onclick = () => { math_eval += '3'; output += '3'; }
number_buttons.four.onclick = () => { math_eval += '4'; output += '4'; }
number_buttons.five.onclick = () => { math_eval += '5'; output += '5'; }
number_buttons.six.onclick = () => { math_eval += '6'; output += '6'; }
number_buttons.seven.onclick = () => { math_eval += '7'; output += '7'; }
number_buttons.eight.onclick = () => { math_eval += '8'; output += '8'; }
number_buttons.nine.onclick = () => { math_eval += '9'; output += '9'; }
number_buttons.dot.onclick = () => { math_eval += '.'; output += '.'; }

/** @type {Object.<string, HTMLButtonElement>} */
let operator_buttons = {
    add: document.getElementById("plu"),
    sub: document.getElementById("min"),
    mult: document.getElementById("mul"),
    div: document.getElementById("div"),
    equ: document.getElementById("equ")
};

operator_buttons.add.onclick = () => {
    math_eval += '+';
    output += '+';
}

operator_buttons.sub.onclick = () => {
    math_eval += '-'
    output += '-'
}

operator_buttons.div.onclick = () => {
    math_eval += '/'
    output += '÷'
}

operator_buttons.mult.onclick = () => {
    math_eval += '*'
    output += '×'
}

operator_buttons.equ.onclick = () => {
    try {
        math_eval = String(mathjs.evaluate(math_eval));
        output = math_eval;
    } catch {
        math_eval = "Invaild"
    }
    
}


let loop = () => {
    math_eval = math_eval.substring(0, max_eval_len);
    output = output.substring(0, max_eval_len);
    result_header.innerText = output;
    requestAnimationFrame(loop);
}

requestAnimationFrame(loop)