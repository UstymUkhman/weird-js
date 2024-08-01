const std = @import("std");

const ArrayList = std.ArrayList;
const Page = std.heap.page_allocator;
const Arena = std.heap.ArenaAllocator;
const Args = std.process.ArgIterator;

const ZERO = "+[]";
const ONE = "+!![]";
const SEP = " + ";

// Initial char strings:
const Chars = struct
{
    a: []u8,
    b: []u8,
    o: []u8,
    e: []u8,
    c: []u8,
    t: []u8,
    space: []u8,
    f: []u8,
    s: []u8,
    r: []u8,
    u: []u8,
    i: []u8,
    n: []u8,
    S: []u8,
    g: []u8,
    p: []u8,
    backslash: []u8,
    d: []u8,
    h: []u8,
    m: []u8,
    C: []u8,
    missing: []u8
};

// Initial char values:
var CHARS = Chars
{
    .a = undefined,
    .b = undefined,
    .o = undefined,
    .e = undefined,
    .c = undefined,
    .t = undefined,
    .space = undefined,
    .f = undefined,
    .s = undefined,
    .r = undefined,
    .u = undefined,
    .i = undefined,
    .n = undefined,
    .S = undefined,
    .g = undefined,
    .p = undefined,
    .backslash = undefined,
    .d = undefined,
    .h = undefined,
    .m = undefined,
    .C = undefined,
    .missing = std.mem.zeroes([]u8)
};

// Get char string from value:
fn get_char(char: u8) []u8
{
    const char_str = switch (char)
    {
        'a' => CHARS.a,
        'b' => CHARS.b,
        'o' => CHARS.o,
        'e' => CHARS.e,
        'c' => CHARS.c,
        't' => CHARS.t,
        ' ', => CHARS.space,
        'f' => CHARS.f,
        's' => CHARS.s,
        'r' => CHARS.r,
        'u' => CHARS.u,
        'i' => CHARS.i,
        'n' => CHARS.n,
        'S' => CHARS.S,
        'g' => CHARS.g,
        'p' => CHARS.p,
        '\\', => CHARS.backslash,
        'd' => CHARS.d,
        'h' => CHARS.h,
        'm' => CHARS.m,
        'C' => CHARS.C,
        else => CHARS.missing
    };

    return char_str;
}

// Create a string matching a
// given number and return it:
fn get_number(num: u8) ![]u8
{
    var num_str = ArrayList(u8).init(Page);

    // There's nothing to loop on if `num` is zero:
    if (num == 0) try num_str.appendSlice(ZERO);

    number: for (0..num) |n| {
        // Append `ONE` number value:
        try num_str.appendSlice(ONE);

        // Break loop on last iteration:
        if (n == num - 1) break :number;

        // Addition to the next `ONE`:
        try num_str.appendSlice(SEP);
    }

    // No need to call `deinit`:
    return num_str.toOwnedSlice();
}

// Compute `JS` code from a given string:
fn from_string(str: []const u8) ![]u8
{
    var char_list = ArrayList(u8).init(Page);

    // Iterate over each char in `str`:
    for (str, 0..) |char, c|
    {
        // Get a string of the current char:
        const char_str = get_char(char);

        // Required char was not found:
        if (char_str.len == 0)
        {
            // Get current char ASCII code:
            var char_code: [1]u8 = undefined;
            _ = try std.unicode.utf8Encode(char, &char_code);

            // Pass it to `fromCharCode` method on string constructor:
            const constructor = try from_string("constructor");
            const from_char_code = try from_string("fromCharCode");
            const index = try get_number(char_code[0]);

            // Compute missing char from return value:
            try char_list.appendSlice("([]+[])[");
            try char_list.appendSlice(constructor);
            try char_list.appendSlice("][");
            try char_list.appendSlice(from_char_code);
            try char_list.appendSlice("](");
            try char_list.appendSlice(index);
            try char_list.append(')');
        }

        // Current char exists in `CHARS`,
        // append it to the output string:
        else try char_list.appendSlice(char_str);

        // Add next character if this is not the last one:
        if (c < str.len - 1) try char_list.appendSlice("+");
    }

    // No need to call `deinit`:
    return char_list.toOwnedSlice();
}

// Compute and save passed char as
// a string into the `CHARS` map:
fn set_char(char: u8) ![]u8
{
    var char_str = ArrayList(u8).init(Page);

    switch (char)
    {
        'a' =>
        {
            const index = try get_number(1);
            try char_str.appendSlice("(+{}+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.a = char_str.items;
        },

        'b' =>
        {
            const index = try get_number(2);
            try char_str.appendSlice("({}+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.b = char_str.items;
        },

        'o' =>
        {
            const index = try get_number(1);
            try char_str.appendSlice("({}+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.o = char_str.items;
        },

        'e' =>
        {
            const index = try get_number(4);
            try char_str.appendSlice("({}+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.e = char_str.items;
        },

        'c' =>
        {
            const index = try get_number(5);
            try char_str.appendSlice("({}+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.c = char_str.items;
        },

        't' =>
        {
            const index = try get_number(6);
            try char_str.appendSlice("({}+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.t = char_str.items;
        },

        ' ' =>
        {
            const index = try get_number(7);
            try char_str.appendSlice("({}+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.space = char_str.items;
        },

        'f' =>
        {
            const index = try get_number(0);
            try char_str.appendSlice("(![]+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.f = char_str.items;
        },

        's' =>
        {
            const index = try get_number(3);
            try char_str.appendSlice("(![]+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.s = char_str.items;
        },

        'r' =>
        {
            const index = try get_number(1);
            try char_str.appendSlice("(!![]+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.r = char_str.items;
        },

        'u' =>
        {
            const index = try get_number(2);
            try char_str.appendSlice("(!![]+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.u = char_str.items;
        },

        'i' =>
        {
            const index = try get_number(3);
            try char_str.appendSlice("((+!![]/+[])+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.i = char_str.items;
        },

        'n' =>
        {
            const index = try get_number(4);
            try char_str.appendSlice("((+!![]/+[])+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.n = char_str.items;
        },

        'S' =>
        {
            const constructor = try from_string("constructor");
            const index = try get_number(9);
            try char_str.appendSlice("([]+([]+[])[");
            try char_str.appendSlice(constructor);
            try char_str.appendSlice("])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.S = char_str.items;
        },

        'g' =>
        {
            const constructor = try from_string("constructor");
            const index = try get_number(14);
            try char_str.appendSlice("([]+([]+[])[");
            try char_str.appendSlice(constructor);
            try char_str.appendSlice("])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.g = char_str.items;
        },

        'p' =>
        {
            const constructor = try from_string("constructor");
            const index = try get_number(14);
            try char_str.appendSlice("([]+(/-/)[");
            try char_str.appendSlice(constructor);
            try char_str.appendSlice("])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.p = char_str.items;
        },

        '\\' =>
        {
            const index = try get_number(1);
            try char_str.appendSlice("(/\\\\/+[])[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.backslash = char_str.items;
        },

        'd' =>
        {
            const toString = try from_string("toString");
            const index = try get_number(13);
            const base = try get_number(14);
            try char_str.append('(');
            try char_str.appendSlice(index);
            try char_str.appendSlice(")[");
            try char_str.appendSlice(toString);
            try char_str.appendSlice("](");
            try char_str.appendSlice(base);
            try char_str.append(')');
            CHARS.d = char_str.items;
        },

        'h' =>
        {
            const toString = try from_string("toString");
            const index = try get_number(17);
            const base = try get_number(18);
            try char_str.append('(');
            try char_str.appendSlice(index);
            try char_str.appendSlice(")[");
            try char_str.appendSlice(toString);
            try char_str.appendSlice("](");
            try char_str.appendSlice(base);
            try char_str.append(')');
            CHARS.h = char_str.items;
        },

        'm' =>
        {
            const toString = try from_string("toString");
            const index = try get_number(22);
            const base = try get_number(23);
            try char_str.append('(');
            try char_str.appendSlice(index);
            try char_str.appendSlice(")[");
            try char_str.appendSlice(toString);
            try char_str.appendSlice("](");
            try char_str.appendSlice(base);
            try char_str.append(')');
            CHARS.m = char_str.items;
        },

        'C' =>
        {
            const constructor = try from_string("constructor");
            const escape = try from_string("return escape");
            const index = try get_number(2);
            try char_str.appendSlice("((()=>{})[");
            try char_str.appendSlice(constructor);
            try char_str.appendSlice("](");
            try char_str.appendSlice(escape);
            try char_str.appendSlice(")()(");
            try char_str.appendSlice(CHARS.backslash);
            try char_str.appendSlice("))[");
            try char_str.appendSlice(index);
            try char_str.append(']');
            CHARS.C = char_str.items;
        },

        else => {}
    }

    // No need to call `deinit`:
    return char_str.toOwnedSlice();
}

// Set initial char strings:
pub fn set_chars() !void
{
    const char_set = [_]u8
    {
        'a',
        'b',
        'o',
        'e',
        'c',
        't',
        ' ',
        'f',
        's',
        'r',
        'u',
        'i',
        'n',
        'S',
        'g',
        'p',
        '\\',
        'd',
        'h',
        'm',
        'C'
    };

    for (char_set) |char| _ = try set_char(char);
}

// Pass `JS` code as a string to the `Function`
// constructor in order to convert it into code:
pub fn compile(code: []const u8) ![]u8
{
    var str = ArrayList(u8).init(Page);

    const constructor = try from_string("constructor");
    const code_str = try from_string(code);

    try str.appendSlice("(()=>{})[");
    try str.appendSlice(constructor);
    try str.appendSlice("](");
    try str.appendSlice(code_str);
    try str.appendSlice(")()");

    // No need to call `deinit`:
    return str.toOwnedSlice();
}

// Command line entry point:
pub fn main() !void
{
    // Create allocator for command line arguments:
    var args = try Args.initWithAllocator(Page);
    defer args.deinit();

    // Set default input and output arguments:
    var arguments: [2][]const u8 = [2][]const u8
    {
        "console.log(\"Hello, World!\");",
        "output"
    };

    // Skip the executable:
    _ = args.skip();

    var a: u8 = 0;

    // Save command line arguments:
    while (args.next()) |arg|
    {
        arguments[a] = arg;
        a += 1;
    }

    // Create output file path from a given file name:
    var path = ArrayList(u8).init(Page);
    defer path.deinit();

    try path.appendSlice("zig-out/");
    try path.appendSlice(arguments[1]);
    try path.appendSlice(".js");

    // Set initial chars:
    try set_chars();

    // Create output file from computed path and close it at the end:
    const file = try std.fs.cwd().createFile(path.items,.{});
    defer file.close();

    // "Compile" input code and write it into a file:
    const output = try compile(arguments[0]);
    _ = try file.writeAll(output);
}
