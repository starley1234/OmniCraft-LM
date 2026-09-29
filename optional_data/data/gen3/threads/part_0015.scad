$fn = 32;

// ----------------------------------------------------------------------
// Hex bolt: M38.1 x 2 thread, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
shank_d = 38.1;           // major diameter
pitch = 2;                // thread pitch
depth = 1.2;              // thread depth
core_d = 35.7;            // minor diameter
length = 60;              // shank length under the head
plain_len = 32.4;         // unthreaded length at the head
thread_len = 27.6;        // threaded length
head_af = 61;             // hex across flats
head_h = 24.8;            // head height
chamfer = 1.5;            // tip chamfer

union() {
  /* hex head */
  cylinder(h = 24.8, d = 70.437, $fn = 6);
  /* shank at the minor diameter, sunk into the head */
  translate([0, 0, head_h - 0.5]) cylinder(h = length + 0.5, d = core_d);
  /* thread ridges: crests at the major diameter, roots inside the shank */
  translate([0, 0, head_h - 0.5 + plain_len]) rotate_extrude() polygon([[15.85, 0], [15.85, 27.6], [19.05, 27.6], [17.55, 26.7], [19.05, 25.6], [17.55, 24.7], [19.05, 23.6], [17.55, 22.7], [19.05, 21.6], [17.55, 20.7], [19.05, 19.6], [17.55, 18.7], [19.05, 17.6], [17.55, 16.7], [19.05, 15.6], [17.55, 14.7], [19.05, 13.6], [17.55, 12.7], [19.05, 11.6], [17.55, 10.7], [19.05, 9.6], [17.55, 8.7], [19.05, 7.6], [17.55, 6.7], [19.05, 5.6], [17.55, 4.7], [19.05, 3.6], [17.55, 2.7], [17.55, 0], [15.85, 0]]);
  /* chamfered tip, exactly on the minor cylinder */
  translate([0, 0, 83.3]) cylinder(h = 1.5, d1 = core_d, d2 = 32.7);
}
