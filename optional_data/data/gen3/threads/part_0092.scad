$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M25.4 x 1.5 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 23.6;            // minor diameter
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
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[9.8, 0], [9.8, 40], [12.7, 40], [11.5, 39.325], [12.7, 38.5], [11.5, 37.825], [12.7, 37], [11.5, 36.325], [12.7, 35.5], [11.5, 34.825], [12.7, 34], [11.5, 33.325], [12.7, 32.5], [11.5, 31.825], [12.7, 31], [11.5, 30.325], [12.7, 29.5], [11.5, 28.825], [12.7, 28], [11.5, 27.325], [12.7, 26.5], [11.5, 25.825], [12.7, 25], [11.5, 24.325], [12.7, 23.5], [11.5, 22.825], [12.7, 22], [11.5, 21.325], [12.7, 20.5], [11.5, 19.825], [12.7, 19], [11.5, 18.325], [12.7, 17.5], [11.5, 16.825], [12.7, 16], [11.5, 15.325], [12.7, 14.5], [11.5, 13.825], [12.7, 13], [11.5, 12.325], [12.7, 11.5], [11.5, 10.825], [12.7, 10], [11.5, 9.325], [12.7, 8.5], [11.5, 7.825], [12.7, 7], [11.5, 6.325], [12.7, 5.5], [11.5, 4.825], [12.7, 4], [11.5, 3.325], [12.7, 2.5], [11.5, 1.825], [11.5, 0], [9.8, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 55]) cylinder(h = 1.5, d1 = core_d, d2 = 20.6);
}
