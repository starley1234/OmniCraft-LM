$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M38.1 x 1.5 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 38.1;           // major diameter
pitch = 1.5;              // thread pitch
depth = 0.9;              // thread depth
core_d = 36.3;            // minor diameter
length = 60;              // shank length under the head
plain_len = 28.2;         // unthreaded length at the head
thread_len = 31.8;        // threaded length
head_af = 61;             // hex across flats
head_h = 24.8;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 24.8, d = 70.437, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[16.15, 0], [16.15, 31.8], [19.05, 31.8], [17.85, 31.125], [19.05, 30.3], [17.85, 29.625], [19.05, 28.8], [17.85, 28.125], [19.05, 27.3], [17.85, 26.625], [19.05, 25.8], [17.85, 25.125], [19.05, 24.3], [17.85, 23.625], [19.05, 22.8], [17.85, 22.125], [19.05, 21.3], [17.85, 20.625], [19.05, 19.8], [17.85, 19.125], [19.05, 18.3], [17.85, 17.625], [19.05, 16.8], [17.85, 16.125], [19.05, 15.3], [17.85, 14.625], [19.05, 13.8], [17.85, 13.125], [19.05, 12.3], [17.85, 11.625], [19.05, 10.8], [17.85, 10.125], [19.05, 9.3], [17.85, 8.625], [19.05, 7.8], [17.85, 7.125], [19.05, 6.3], [17.85, 5.625], [19.05, 4.8], [17.85, 4.125], [19.05, 3.3], [17.85, 2.625], [17.85, 0], [16.15, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 83.3]) cylinder(h = 1.5, d1 = core_d, d2 = 33.3);
}
