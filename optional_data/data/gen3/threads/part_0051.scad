$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M19.05 x 1.5 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 19.05;          // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 17.25;           // minor diameter
length = 40;              // shank length under the head
plain_len = 20.4;         // unthreaded length at the head
thread_len = 19.6;        // threaded length
head_af = 30.5;           // hex across flats
head_h = 12.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 12.4, d = 35.218, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[6.625, 0], [6.625, 19.6], [9.525, 19.6], [8.325, 18.925], [9.525, 18.1], [8.325, 17.425], [9.525, 16.6], [8.325, 15.925], [9.525, 15.1], [8.325, 14.425], [9.525, 13.6], [8.325, 12.925], [9.525, 12.1], [8.325, 11.425], [9.525, 10.6], [8.325, 9.925], [9.525, 9.1], [8.325, 8.425], [9.525, 7.6], [8.325, 6.925], [9.525, 6.1], [8.325, 5.425], [9.525, 4.6], [8.325, 3.925], [9.525, 3.1], [8.325, 2.425], [8.325, 0], [6.625, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 50.9]) cylinder(h = 1.5, d1 = core_d, d2 = 14.25);
}
