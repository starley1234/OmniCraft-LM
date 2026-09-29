$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M25.4 x 2 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 23;              // minor diameter
length = 40;              // shank length under the head
thread_len = 40;          // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[9.5, 0], [9.5, 40], [12.7, 40], [11.2, 39.1], [12.7, 38], [11.2, 37.1], [12.7, 36], [11.2, 35.1], [12.7, 34], [11.2, 33.1], [12.7, 32], [11.2, 31.1], [12.7, 30], [11.2, 29.1], [12.7, 28], [11.2, 27.1], [12.7, 26], [11.2, 25.1], [12.7, 24], [11.2, 23.1], [12.7, 22], [11.2, 21.1], [12.7, 20], [11.2, 19.1], [12.7, 18], [11.2, 17.1], [12.7, 16], [11.2, 15.1], [12.7, 14], [11.2, 13.1], [12.7, 12], [11.2, 11.1], [12.7, 10], [11.2, 9.1], [12.7, 8], [11.2, 7.1], [12.7, 6], [11.2, 5.1], [12.7, 4], [11.2, 3.1], [11.2, 0], [9.5, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 55]) cylinder(h = 1.5, d1 = core_d, d2 = 20);
}
