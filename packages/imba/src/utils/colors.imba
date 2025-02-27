const colors = {
	reset: [0, 0]

	bold: [1, 22]
	dim: [2, 22]
	italic: [3, 23]
	underline: [4, 24]
	inverse: [7, 27]
	hidden: [8, 28]
	strikethrough: [9, 29]

	black: [30, 39]
	red: [31, 39]
	green: [32, 39]
	yellow: [33, 39]
	blue: [34, 39]
	magenta: [35, 39]
	cyan: [36, 39]
	white: [37, 39]
	gray: [90, 39]
	grey: [90, 39]

	brightRed: [91, 39]
	brightGreen: [92, 39]
	brightYellow: [93, 39]
	brightBlue: [94, 39]
	brightMagenta: [95, 39]
	brightCyan: [96, 39]
	brightWhite: [97, 39]

	bgBlack: [40, 49]
	bgRed: [41, 49]
	bgGreen: [42, 49]
	bgYellow: [43, 49]
	bgBlue: [44, 49]
	bgMagenta: [45, 49]
	bgCyan: [46, 49]
	bgWhite: [47, 49]
	bgGray: [100, 49]
	bgGrey: [100, 49]

	bgBrightRed: [101, 49]
	bgBrightGreen: [102, 49]
	bgBrightYellow: [103, 49]
	bgBrightBlue: [104, 49]
	bgBrightMagenta: [105, 49]
	bgBrightCyan: [106, 49]
	bgBrightWhite: [107, 49]
}

for own name, [open, close] of colors
	String.prototype.__defineGetter__ name, do
		'\x1b[' + open + 'm' + this + '\x1b[' + close + 'm'

let c = {}
for own name, [open, close] of colors
	c[name] = do '\x1b[' + open + 'm' + $1 + '\x1b[' + close + 'm'

export default c

# console.log "Hello this is a {"blue".blue} string and a {"red".red} one and a {"green".green} one."
# console.log "Hello this is a {c.blue("blue")} string and a {c.red("red")} one and a {c.green("green")} one."
