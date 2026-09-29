$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M25.4 x 1.75 thread, 70 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 25.4;           // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 23.3;            // minor diameter
length = 70;              // shank length under the head
plain_len = 36.4;         // unthreaded length at the head
thread_len = 33.6;        // threaded length
head_af = 40.6;           // hex across flats
head_h = 16.5;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 16.5, d = 46.881, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[9.65, 0], [9.65, 33.6], [12.7, 33.6], [11.35, 32.812], [12.7, 31.85], [11.35, 31.062], [12.7, 30.1], [11.35, 29.312], [12.7, 28.35], [11.35, 27.562], [12.7, 26.6], [11.35, 25.812], [12.7, 24.85], [11.35, 24.062], [12.7, 23.1], [11.35, 22.312], [12.7, 21.35], [11.35, 20.562], [12.7, 19.6], [11.35, 18.812], [12.7, 17.85], [11.35, 17.062], [12.7, 16.1], [11.35, 15.313], [12.7, 14.35], [11.35, 13.562], [12.7, 12.6], [11.35, 11.812], [12.7, 10.85], [11.35, 10.062], [12.7, 9.1], [11.35, 8.312], [12.7, 7.35], [11.35, 6.562], [12.7, 5.6], [11.35, 4.812], [12.7, 3.85], [11.35, 3.062], [11.35, 0], [9.65, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 85]) cylinder(h = 1.5, d1 = core_d, d2 = 20.3);
}
