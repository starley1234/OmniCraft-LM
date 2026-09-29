$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M6.6 x 1.5 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 6.6;            // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 4.8;             // minor diameter
length = 60;              // shank length under the head
plain_len = 29.4;         // unthreaded length at the head
thread_len = 30.6;        // threaded length
head_af = 10.6;           // hex across flats
head_h = 4.3;             // head height
chamfer = 0.96;           // tip chamfer

union() {
  /* hex head */
  cylinder(h = 4.3, d = 12.24, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[0.5, 0], [0.5, 30.6], [3.3, 30.6], [2.1, 29.925], [3.3, 29.1], [2.1, 28.425], [3.3, 27.6], [2.1, 26.925], [3.3, 26.1], [2.1, 25.425], [3.3, 24.6], [2.1, 23.925], [3.3, 23.1], [2.1, 22.425], [3.3, 21.6], [2.1, 20.925], [3.3, 20.1], [2.1, 19.425], [3.3, 18.6], [2.1, 17.925], [3.3, 17.1], [2.1, 16.425], [3.3, 15.6], [2.1, 14.925], [3.3, 14.1], [2.1, 13.425], [3.3, 12.6], [2.1, 11.925], [3.3, 11.1], [2.1, 10.425], [3.3, 9.6], [2.1, 8.925], [3.3, 8.1], [2.1, 7.425], [3.3, 6.6], [2.1, 5.925], [3.3, 5.1], [2.1, 4.425], [3.3, 3.6], [2.1, 2.925], [3.3, 2.1], [2.1, 1.425], [2.1, 0], [0.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 63.34]) cylinder(h = 0.96, d1 = core_d, d2 = 2.88);
}
