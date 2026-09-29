$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 1.5 thread, 50 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 23.6;            // minor diameter
length = 50;              // shank length under the head
plain_len = 22.5;         // unthreaded length at the head
thread_len = 27.5;        // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.8, 0], [9.8, 27.5], [12.7, 27.5], [11.5, 26.825], [12.7, 26], [11.5, 25.325], [12.7, 24.5], [11.5, 23.825], [12.7, 23], [11.5, 22.325], [12.7, 21.5], [11.5, 20.825], [12.7, 20], [11.5, 19.325], [12.7, 18.5], [11.5, 17.825], [12.7, 17], [11.5, 16.325], [12.7, 15.5], [11.5, 14.825], [12.7, 14], [11.5, 13.325], [12.7, 12.5], [11.5, 11.825], [12.7, 11], [11.5, 10.325], [12.7, 9.5], [11.5, 8.825], [12.7, 8], [11.5, 7.325], [12.7, 6.5], [11.5, 5.825], [12.7, 5], [11.5, 4.325], [12.7, 3.5], [11.5, 2.825], [11.5, 0], [9.8, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 65]) cylinder(h = 1.5, d1 = core_d, d2 = 20.6);
}
