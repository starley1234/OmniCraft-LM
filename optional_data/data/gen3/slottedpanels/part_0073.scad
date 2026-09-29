$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 90 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 90;             // panel depth
thick = 8;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 60;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 52.32 */
  hull() {
    translate([48.84, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([101.16, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11, length 68.02 */
  hull() {
    translate([40.99, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([109.01, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 83.71 */
  hull() {
    translate([33.15, 35.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([116.86, 35.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11, length 99.41 */
  hull() {
    translate([25.3, 46.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([124.71, 46.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 115.1 */
  hull() {
    translate([17.45, 57.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([132.55, 57.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 11, length 130.8 */
  hull() {
    translate([9.6, 68.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140.4, 68.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.8, -2.5]) cylinder(h = 13, d = mount_d);
  translate([15, 85.2, -2.5]) cylinder(h = 13, d = mount_d);
  translate([135, 4.8, -2.5]) cylinder(h = 13, d = mount_d);
  translate([135, 85.2, -2.5]) cylinder(h = 13, d = mount_d);
}
