$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M19.05 x 1.75 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 19.05;          // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 16.95;           // minor diameter
length = 40;              // shank length under the head
plain_len = 20;           // unthreaded length at the head
thread_len = 20;          // threaded length
head_af = 30.5;           // hex across flats
head_h = 12.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 12.4, d = 35.218, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[6.475, 0], [6.475, 20], [9.525, 20], [8.175, 19.212], [9.525, 18.25], [8.175, 17.462], [9.525, 16.5], [8.175, 15.713], [9.525, 14.75], [8.175, 13.963], [9.525, 13], [8.175, 12.213], [9.525, 11.25], [8.175, 10.463], [9.525, 9.5], [8.175, 8.713], [9.525, 7.75], [8.175, 6.963], [9.525, 6], [8.175, 5.213], [9.525, 4.25], [8.175, 3.462], [9.525, 2.5], [8.175, 1.712], [8.175, 0], [6.475, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 50.9]) cylinder(h = 1.5, d1 = core_d, d2 = 13.95);
}
