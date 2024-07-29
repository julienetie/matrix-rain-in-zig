const std = @import("std");
const raylib = @import("raylib");
const panic = std.debug.panic;

var prng = std.Random.DefaultPrng.init(42);
const rand = prng.random();

const TrailCharacter: type = struct {
    character: i32,
    changeFrame: c_int,

    pub fn init(character: i32, changeFrame: c_int) TrailCharacter {
        return TrailCharacter{ .character = character, .changeFrame = changeFrame };
    }

    pub fn getCharacter(self: *TrailCharacter) i32 {
        return self.character;
    }

    pub fn setCharacter(self: *TrailCharacter, character: i32) void {
        self.character = character;
    }

    pub fn getChangeFrame(self: *TrailCharacter) c_int {
        return self.changeFrame;
    }

    pub fn setChangeFrame(self: *TrailCharacter, changeFrame: c_int) void {
        self.changeFrame = changeFrame;
    }

    fn get_random_char() i32 {
        return @as(i32, @intCast(rand_range(1, 255)));
    }
};

const Trail: type = struct {
    x: c_int,
    y: c_int,
    fallSpeed: c_int,
    textSize: c_int,
    trailLength: usize,
    textColor: raylib.Color,
    depthView: c_int,
    trail_array: []TrailCharacter,

    pub fn init(x: c_int, y: c_int, failSpeed: c_int, textSize: c_int, trailLength: usize, depthView: c_int, textColor: raylib.Color, array: []TrailCharacter) !Trail {
        // Unsafe Not Feeling the allocator
        const allocator = std.heap.page.allocator;
        const trail_array: []TrailCharacter = allocator.alloc(TrailCharacter, trailLength) catch |err| {
            panic("Error : Unable to allocate memory to {s}, {}", .{ "Trail Character Array", err });
            return undefined;
        };

        for (0..trailLength) |i| {
            trail_array[i] = array[i];
        }

        return Trail{
            .x = x,
            .y = y,
            .fallSpeed = fallSpeed,
            .textSize = textSize,
            .trailLength = trailLength,
            .depthView = depthView,
            .textColor = textColor,
            .trail_array = trail_array,
        };
    }

    pub fn setX(self: *Trail, x: c_int) void {
        self.x = x;
    }

    pub fn getX(self: *Trail) c_int {
        return self.x;
    }

    pub fn setY(self: *Trail, y: c_int) void {
        self.y = y;
    }

    pub fn getY(self: *Trail) c_int {
        return self.y;
    }

    pub fn setFallSpeed(self: *Trail, fallSpeed: c_int) void {
        self.fallSpeed = fallSpeed;
    }

    pub fn getFallSpeed(self: *Trail) c_int {
        return self.fallSpeed;
    }

    pub fn setTextSize(self: *Trail, textSize: c_int) void {
        self.textSize = textSize;
    }

    pub fn getTextSize(self: *Trail) c_int {
        return self.textSize;
    }
    pub fn setDepth(self: *Trail, depthView: c_int) void {
        self.depthView = depthView;
    }

    pub fn getDepth(self: *Trail) c_int {
        return self.depthView;
    }

    pub fn setTrailLength(self: *Trail, trailLength: c_int) void {
        self.trailLength = trailLength;
    }

    pub fn getTrailLength(self: *Trail) usize {
        return self.trailLength;
    }

    pub fn setTextColor(self: *Trail, textColor: c_int) void {
        self.textColor = textColor;
    }

    pub fn getTextColor(self: *Trail) raylib.Color {
        return self.textColor;
    }

    pub fn getTrailArray(self: *Trail) []TrailCharacter {
        return self.trail_array;
    }

    pub fn setTrailArray(self: *Trail, trail_array: []TrailCharacter) void {
        for (0..self.trailLength) |i| {
            self.trail_array[i] = trail_array[i];
        }
    }
};
