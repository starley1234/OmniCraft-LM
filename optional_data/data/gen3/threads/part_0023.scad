$fn = 32;

// ----------------------------------------------------------------------
// Threaded stud: M22.23 x 1.75 thread, 40 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 22.23;          // major diameter
pitch = 1.75;             // thread pitch
depth = 1.05;             // thread depth
core_d = 20.12;           // minor diameter
length = 40;              // shank length under the head
thread_len = 40;          // threaded length
head_af = 35.6;           // hex across flats
head_h = 14.4;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 14.4, d = 41.107, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5]) rotate_extrude() polygon([[8.062, 0], [8.062, 40], [11.113, 40], [9.762, 39.212], [11.113, 38.25], [9.762, 37.462], [11.113, 36.5], [9.762, 35.712], [11.113, 34.75], [9.762, 33.962], [11.113, 33], [9.762, 32.212], [11.113, 31.25], [9.762, 30.462], [11.113, 29.5], [9.762, 28.712], [11.113, 27.75], [9.762, 26.962], [11.113, 26], [9.762, 25.212], [11.113, 24.25], [9.762, 23.462], [11.113, 22.5], [9.762, 21.712], [11.113, 20.75], [9.762, 19.962], [11.113, 19], [9.762, 18.212], [11.113, 17.25], [9.762, 16.462], [11.113, 15.5], [9.762, 14.713], [11.113, 13.75], [9.762, 12.963], [11.113, 12], [9.762, 11.213], [11.113, 10.25], [9.762, 9.463], [11.113, 8.5], [9.762, 7.713], [11.113, 6.75], [9.762, 5.963], [11.113, 5], [9.762, 4.213], [11.113, 3.25], [9.762, 2.462], [9.762, 0], [8.062, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 52.9]) cylinder(h = 1.5, d1 = core_d, d2 = 17.124);
}
