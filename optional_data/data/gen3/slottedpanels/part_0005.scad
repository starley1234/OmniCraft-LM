$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 100 mm, 7 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 100;            // panel depth
thick = 5;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 7;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 63;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 50.4 */
  hull() {
    translate([49.8, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100.2, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11, length 65.52 */
  hull() {
    translate([42.24, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([107.76, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 80.64 */
  hull() {
    translate([34.68, 36.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([115.32, 36.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11, length 95.76 */
  hull() {
    translate([27.12, 47.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([122.88, 47.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 110.88 */
  hull() {
    translate([19.56, 58.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([130.44, 58.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 11, length 126 */
  hull() {
    translate([12, 69.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 69.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 6: pitch 11, length 126 */
  hull() {
    translate([12, 80.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 80.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([12, 94, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([138, 94, -2.5]) cylinder(h = 10, d = mount_d);
}
