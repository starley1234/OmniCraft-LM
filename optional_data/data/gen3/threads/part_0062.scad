$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M12.7 x 1.5 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 12.7;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 10.9;            // minor diameter
length = 40;              // shank length under the head
thread_len = 40;          // threaded length
head_af = 20.3;           // hex across flats
head_h = 8.3;             // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 8.3, d = 23.44, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[3.45, 0], [3.45, 40], [6.35, 40], [5.15, 39.325], [6.35, 38.5], [5.15, 37.825], [6.35, 37], [5.15, 36.325], [6.35, 35.5], [5.15, 34.825], [6.35, 34], [5.15, 33.325], [6.35, 32.5], [5.15, 31.825], [6.35, 31], [5.15, 30.325], [6.35, 29.5], [5.15, 28.825], [6.35, 28], [5.15, 27.325], [6.35, 26.5], [5.15, 25.825], [6.35, 25], [5.15, 24.325], [6.35, 23.5], [5.15, 22.825], [6.35, 22], [5.15, 21.325], [6.35, 20.5], [5.15, 19.825], [6.35, 19], [5.15, 18.325], [6.35, 17.5], [5.15, 16.825], [6.35, 16], [5.15, 15.325], [6.35, 14.5], [5.15, 13.825], [6.35, 13], [5.15, 12.325], [6.35, 11.5], [5.15, 10.825], [6.35, 10], [5.15, 9.325], [6.35, 8.5], [5.15, 7.825], [6.35, 7], [5.15, 6.325], [6.35, 5.5], [5.15, 4.825], [6.35, 4], [5.15, 3.325], [6.35, 2.5], [5.15, 1.825], [5.15, 0], [3.45, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 46.8]) cylinder(h = 1.5, d1 = core_d, d2 = 7.9);
}
