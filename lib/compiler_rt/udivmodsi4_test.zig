// Disable formatting to avoid unnecessary source repository bloat.
// zig fmt: off
const testing = @import("std").testing;
const builtin = @import("builtin");
const __aeabi_uidivmod = @import("arm.zig").__aeabi_uidivmod;

const ARMRes = extern struct {
    q: u32, // r0
    r: u32, // r1
};

fn test__aeabi_uidivmod(a: u32, b: u32, expected_q: u32, expected_r: u32) !void {
    const actualUidivmod = @as(*const fn (a: u32, b: u32) callconv(.AAPCS) ARMRes, @ptrCast(&__aeabi_uidivmod));
    const arm_res = actualUidivmod(a, b);
    try testing.expectEqual(expected_q, arm_res.q);
    try testing.expectEqual(expected_r, arm_res.r);
}

test "arm.__aeabi_uidivmod" {
    if (!builtin.cpu.arch.isARM()) return error.SkipZigTest;

    var i: i32 = 0;
    for (cases) |case| {
        try test__aeabi_uidivmod(case[0], case[1], case[2], case[3]);
        i+=1;
    }
}

const cases = [_][4]u32{
    [_]u32{0x00000000, 0x00000001, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0x00000002, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0x00000003, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0x00000010, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0x078644FA, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0x0747AE14, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0x7FFFFFFF, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0x80000000, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0xFFFFFFFD, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0xFFFFFFFE, 0x00000000, 0x00000000},
    [_]u32{0x00000000, 0xFFFFFFFF, 0x00000000, 0x00000000},
    [_]u32{0x00000001, 0x00000001, 0x00000001, 0x00000000}, // 1/1 => q=1, r=0
    [_]u32{0x00000001, 0x00000002, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x00000003, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x00000010, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x078644FA, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x0747AE14, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x7FFFFFFF, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x80000000, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0xFFFFFFFD, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0xFFFFFFFE, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0xFFFFFFFF, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x00000000, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x00000001, 0x00000001, 0x00000000},
    [_]u32{0x00000001, 0x00000002, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x00000003, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x00000010, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x078644FA, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x0747AE14, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x7FFFFFFF, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0x80000000, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0xFFFFFFFD, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0xFFFFFFFE, 0x00000000, 0x00000001},
    [_]u32{0x00000001, 0xFFFFFFFF, 0x00000000, 0x00000001},
    [_]u32{0x00000002, 0x00000001, 0x00000002, 0x00000000},
    [_]u32{0x00000002, 0x00000002, 0x00000001, 0x00000000},
    [_]u32{0x00000002, 0x00000003, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0x00000010, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0x078644FA, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0x0747AE14, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0x7FFFFFFF, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0x80000000, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0xFFFFFFFD, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0xFFFFFFFE, 0x00000000, 0x00000002},
    [_]u32{0x00000002, 0xFFFFFFFF, 0x00000000, 0x00000002},

    [_]u32{0x00000010, 0x00000001, 0x00000010, 0x00000000},
    [_]u32{0x00000010, 0x00000002, 0x00000008, 0x00000000},
    [_]u32{0x00000010, 0x00000003, 0x00000005, 0x00000001},
    [_]u32{0x00000010, 0x00000010, 0x00000001, 0x00000000},
    [_]u32{0x00000010, 0x078644FA, 0x00000000, 0x00000010},
    [_]u32{0x00000010, 0x0747AE14, 0x00000000, 0x00000010},
    [_]u32{0x00000010, 0x7FFFFFFF, 0x00000000, 0x00000010},
    [_]u32{0x00000010, 0x80000000, 0x00000000, 0x00000010},
    [_]u32{0x00000010, 0xFFFFFFFD, 0x00000000, 0x00000010},
    [_]u32{0x00000010, 0xFFFFFFFE, 0x00000000, 0x00000010},
    [_]u32{0x00000010, 0xFFFFFFFF, 0x00000000, 0x00000010},

    [_]u32{0x078644FA, 0x00000001, 0x078644FA, 0x00000000},
    [_]u32{0x078644FA, 0x00000002, 0x03C3227D, 0x00000000},
    [_]u32{0x078644FA, 0x00000003, 0x028216FE, 0x00000000},
    [_]u32{0x078644FA, 0x00000010, 0x0078644F, 0x0000000A},
    [_]u32{0x078644FA, 0x078644FA, 0x00000001, 0x00000000},
    [_]u32{0x078644FA, 0x0747AE14, 0x00000001, 0x003E96E6},
    [_]u32{0x078644FA, 0x7FFFFFFF, 0x00000000, 0x078644FA},
    [_]u32{0x078644FA, 0x80000000, 0x00000000, 0x078644FA},
    [_]u32{0x078644FA, 0xFFFFFFFD, 0x00000000, 0x078644FA},
    [_]u32{0x078644FA, 0xFFFFFFFE, 0x00000000, 0x078644FA},
    [_]u32{0x078644FA, 0xFFFFFFFF, 0x00000000, 0x078644FA},
    [_]u32{0x0747AE14, 0x00000001, 0x0747AE14, 0x00000000},
    [_]u32{0x0747AE14, 0x00000002, 0x03A3D70A, 0x00000000},
    [_]u32{0x0747AE14, 0x00000003, 0x026D3A06, 0x00000002},
    [_]u32{0x0747AE14, 0x00000010, 0x00747AE1, 0x00000004},
    [_]u32{0x0747AE14, 0x078644FA, 0x00000000, 0x0747AE14},
    [_]u32{0x0747AE14, 0x0747AE14, 0x00000001, 0x00000000},
    [_]u32{0x0747AE14, 0x7FFFFFFF, 0x00000000, 0x0747AE14},
    [_]u32{0x0747AE14, 0x80000000, 0x00000000, 0x0747AE14},
    [_]u32{0x0747AE14, 0xFFFFFFFD, 0x00000000, 0x0747AE14},
    [_]u32{0x0747AE14, 0xFFFFFFFE, 0x00000000, 0x0747AE14},
    [_]u32{0x0747AE14, 0xFFFFFFFF, 0x00000000, 0x0747AE14},
    [_]u32{0x7FFFFFFF, 0x00000001, 0x7FFFFFFF, 0x00000000},
    [_]u32{0x7FFFFFFF, 0x00000002, 0x3FFFFFFF, 0x00000001},
    [_]u32{0x7FFFFFFF, 0x00000003, 0x2AAAAAAA, 0x00000001},
    [_]u32{0x7FFFFFFF, 0x00000010, 0x07FFFFFF, 0x0000000F},
    [_]u32{0x7FFFFFFF, 0x078644FA, 0x00000011, 0x00156B65},
    [_]u32{0x7FFFFFFF, 0x0747AE14, 0x00000011, 0x043D70AB},
    [_]u32{0x7FFFFFFF, 0x7FFFFFFF, 0x00000001, 0x00000000},
    [_]u32{0x7FFFFFFF, 0x80000000, 0x00000000, 0x7FFFFFFF},
    [_]u32{0x7FFFFFFF, 0xFFFFFFFD, 0x00000000, 0x7FFFFFFF},
    [_]u32{0x7FFFFFFF, 0xFFFFFFFE, 0x00000000, 0x7FFFFFFF},
    [_]u32{0x7FFFFFFF, 0xFFFFFFFF, 0x00000000, 0x7FFFFFFF},
    [_]u32{0x80000000, 0x00000001, 0x80000000, 0x00000000},
    [_]u32{0x80000000, 0x00000002, 0x40000000, 0x00000000},
    [_]u32{0x80000000, 0x00000003, 0x2AAAAAAA, 0x00000002},
    [_]u32{0x80000000, 0x00000010, 0x08000000, 0x00000000},
    [_]u32{0x80000000, 0x078644FA, 0x00000011, 0x00156B66},
    [_]u32{0x80000000, 0x0747AE14, 0x00000011, 0x043D70AC},
    [_]u32{0x80000000, 0x7FFFFFFF, 0x00000001, 0x00000001},
    [_]u32{0x80000000, 0x80000000, 0x00000001, 0x00000000},
    [_]u32{0x80000000, 0xFFFFFFFD, 0x00000000, 0x80000000},
    [_]u32{0x80000000, 0xFFFFFFFE, 0x00000000, 0x80000000},
    [_]u32{0x80000000, 0xFFFFFFFF, 0x00000000, 0x80000000},
    [_]u32{0xFFFFFFFD, 0x00000001, 0xFFFFFFFD, 0x00000000},
    [_]u32{0xFFFFFFFD, 0x00000002, 0x7FFFFFFE, 0x00000001},
    [_]u32{0xFFFFFFFD, 0x00000003, 0x55555554, 0x00000001},
    [_]u32{0xFFFFFFFD, 0x00000010, 0x0FFFFFFF, 0x0000000D},
    [_]u32{0xFFFFFFFD, 0x078644FA, 0x00000022, 0x002AD6C9},
    [_]u32{0xFFFFFFFD, 0x0747AE14, 0x00000023, 0x01333341},
    [_]u32{0xFFFFFFFD, 0x7FFFFFFF, 0x00000001, 0x7FFFFFFE},
    [_]u32{0xFFFFFFFD, 0x80000000, 0x00000001, 0x7FFFFFFD},
    [_]u32{0xFFFFFFFD, 0xFFFFFFFD, 0x00000001, 0x00000000},
    [_]u32{0xFFFFFFFD, 0xFFFFFFFE, 0x00000000, 0xFFFFFFFD},
    [_]u32{0xFFFFFFFD, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFD},
    [_]u32{0xFFFFFFFE, 0x00000001, 0xFFFFFFFE, 0x00000000},
    [_]u32{0xFFFFFFFE, 0x00000002, 0x7FFFFFFF, 0x00000000},
    [_]u32{0xFFFFFFFE, 0x00000003, 0x55555554, 0x00000002},
    [_]u32{0xFFFFFFFE, 0x00000010, 0x0FFFFFFF, 0x0000000E},
    [_]u32{0xFFFFFFFE, 0x078644FA, 0x00000022, 0x002AD6CA},
    [_]u32{0xFFFFFFFE, 0x0747AE14, 0x00000023, 0x01333342},
    [_]u32{0xFFFFFFFE, 0x7FFFFFFF, 0x00000002, 0x00000000},
    [_]u32{0xFFFFFFFE, 0x80000000, 0x00000001, 0x7FFFFFFE},
    [_]u32{0xFFFFFFFE, 0xFFFFFFFD, 0x00000001, 0x00000001},
    [_]u32{0xFFFFFFFE, 0xFFFFFFFE, 0x00000001, 0x00000000},
    [_]u32{0xFFFFFFFE, 0xFFFFFFFF, 0x00000000, 0xFFFFFFFE},
    [_]u32{0xFFFFFFFF, 0x00000001, 0xFFFFFFFF, 0x00000000},
    [_]u32{0xFFFFFFFF, 0x00000002, 0x7FFFFFFF, 0x00000001},
    [_]u32{0xFFFFFFFF, 0x00000003, 0x55555555, 0x00000000},
    [_]u32{0xFFFFFFFF, 0x00000010, 0x0FFFFFFF, 0x0000000F},
    [_]u32{0xFFFFFFFF, 0x078644FA, 0x00000022, 0x002AD6CB},
    [_]u32{0xFFFFFFFF, 0x0747AE14, 0x00000023, 0x01333343},
    [_]u32{0xFFFFFFFF, 0x7FFFFFFF, 0x00000002, 0x00000001},
    [_]u32{0xFFFFFFFF, 0x80000000, 0x00000001, 0x7FFFFFFF},
    [_]u32{0xFFFFFFFF, 0xFFFFFFFD, 0x00000001, 0x00000002},
    [_]u32{0xFFFFFFFF, 0xFFFFFFFE, 0x00000001, 0x00000001},
    [_]u32{0xFFFFFFFF, 0xFFFFFFFF, 0x00000001, 0x00000000},
};