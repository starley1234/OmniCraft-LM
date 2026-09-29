$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 1.5 thread, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 23.6;            // minor diameter
length = 70;              // shank length under the head
plain_len = 29.4;         // unthreaded length at the head
thread_len = 40.6;        // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.8, 0], [9.8, 40.6], [12.7, 40.6], [11.5, 39.925], [12.7, 39.1], [11.5, 38.425], [12.7, 37.6], [11.5, 36.925], [12.7, 36.1], [11.5, 35.425], [12.7, 34.6], [11.5, 33.925], [12.7, 33.1], [11.5, 32.425], [12.7, 31.6], [11.5, 30.925], [12.7, 30.1], [11.5, 29.425], [12.7, 28.6], [11.5, 27.925], [12.7, 27.1], [11.5, 26.425], [12.7, 25.6], [11.5, 24.925], [12.7, 24.1], [11.5, 23.425], [12.7, 22.6], [11.5, 21.925], [12.7, 21.1], [11.5, 20.425], [12.7, 19.6], [11.5, 18.925], [12.7, 18.1], [11.5, 17.425], [12.7, 16.6], [11.5, 15.925], [12.7, 15.1], [11.5, 14.425], [12.7, 13.6], [11.5, 12.925], [12.7, 12.1], [11.5, 11.425], [12.7, 10.6], [11.5, 9.925], [12.7, 9.1], [11.5, 8.425], [12.7, 7.6], [11.5, 6.925], [12.7, 6.1], [11.5, 5.425], [12.7, 4.6], [11.5, 3.925], [12.7, 3.1], [11.5, 2.425], [11.5, 0], [9.8, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 85]) cylinder(h = 1.5, d1 = core_d, d2 = 20.6);
}
