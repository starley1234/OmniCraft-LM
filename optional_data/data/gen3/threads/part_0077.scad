$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M31.75 x 1.5 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 31.75;          // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 29.95;           // minor diameter
length = 50;              // shank length under the head
plain_len = 27;           // unthreaded length at the head
thread_len = 23;          // threaded length
head_af = 50.8;           // hex across flats
head_h = 20.6;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 20.6, d = 58.659, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[12.975, 0], [12.975, 23], [15.875, 23], [14.675, 22.325], [15.875, 21.5], [14.675, 20.825], [15.875, 20], [14.675, 19.325], [15.875, 18.5], [14.675, 17.825], [15.875, 17], [14.675, 16.325], [15.875, 15.5], [14.675, 14.825], [15.875, 14], [14.675, 13.325], [15.875, 12.5], [14.675, 11.825], [15.875, 11], [14.675, 10.325], [15.875, 9.5], [14.675, 8.825], [15.875, 8], [14.675, 7.325], [15.875, 6.5], [14.675, 5.825], [15.875, 5], [14.675, 4.325], [15.875, 3.5], [14.675, 2.825], [14.675, 0], [12.975, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 69.1]) cylinder(h = 1.5, d1 = core_d, d2 = 26.95);
}
