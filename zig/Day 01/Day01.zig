const std = @import("std");

const Digit = struct { word: []const u8, value: i32 };
const digits = [_]Digit{
    .{ .word = "1", .value = 1 },
    .{ .word = "2", .value = 2 },
    .{ .word = "3", .value = 3 },
    .{ .word = "4", .value = 4 },
    .{ .word = "5", .value = 5 },
    .{ .word = "6", .value = 6 },
    .{ .word = "7", .value = 7 },
    .{ .word = "8", .value = 8 },
    .{ .word = "9", .value = 9 },
};

const wordDigit = [_]Digit{
    .{ .word = "one", .value = 1 },
    .{ .word = "two", .value = 2 },
    .{ .word = "three", .value = 3 },
    .{ .word = "four", .value = 4 },
    .{ .word = "five", .value = 5 },
    .{ .word = "six", .value = 6 },
    .{ .word = "seven", .value = 7 },
    .{ .word = "eight", .value = 8 },
    .{ .word = "nine", .value = 9 },
};

const todo = digits ++ wordDigit;

fn getDigit(line: []const u8, pattern: []const Digit) i32 {
    var first: i32 = -1;
    var second: i32 = 0;
    var start_idx: usize = 0;

    for (line, 0..) |_, end_idx| {
        for (pattern) |digit| {
            if (std.mem.indexOf(u8, line[start_idx .. end_idx + 1], digit.word)) |idx| {
                const value = digit.value;
                if (first == -1) {
                    first = value;
                }
                second = value;
                start_idx += idx + 1;
                break;
            }
        }
    }
    return first * 10 + second;
}

pub fn main() !void {
    const input = @embedFile("input.txt");
    var part1: i32 = 0;
    var part2: i32 = 0;
    var it = std.mem.tokenizeAny(u8, input, "\n");
    while (it.next()) |line| {
        part1 += getDigit(line, &digits);
        part2 += getDigit(line, &todo);
    }
    std.debug.print("part1 = {d}\n", .{part1});
    std.debug.print("part2 = {d}\n", .{part2});
}
