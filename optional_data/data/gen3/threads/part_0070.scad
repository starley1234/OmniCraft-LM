$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M12.7 x 1.75 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 12.7;           // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 10.6;            // minor diameter
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
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[3.3, 0], [3.3, 40], [6.35, 40], [5, 39.212], [6.35, 38.25], [5, 37.462], [6.35, 36.5], [5, 35.712], [6.35, 34.75], [5, 33.962], [6.35, 33], [5, 32.212], [6.35, 31.25], [5, 30.462], [6.35, 29.5], [5, 28.712], [6.35, 27.75], [5, 26.962], [6.35, 26], [5, 25.212], [6.35, 24.25], [5, 23.462], [6.35, 22.5], [5, 21.712], [6.35, 20.75], [5, 19.962], [6.35, 19], [5, 18.212], [6.35, 17.25], [5, 16.462], [6.35, 15.5], [5, 14.713], [6.35, 13.75], [5, 12.963], [6.35, 12], [5, 11.213], [6.35, 10.25], [5, 9.463], [6.35, 8.5], [5, 7.713], [6.35, 6.75], [5, 5.963], [6.35, 5], [5, 4.213], [6.35, 3.25], [5, 2.462], [5, 0], [3.3, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 46.8]) cylinder(h = 1.5, d1 = core_d, d2 = 7.6);
}
