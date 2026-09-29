$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 100;            // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 60;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 126 */
  hull() {
    translate([12, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 15.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.8, length 126 */
  hull() {
    translate([12, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 28.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 126 */
  hull() {
    translate([12, 43.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 43.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.8, length 126 */
  hull() {
    translate([12, 56.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 56.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 13, length 126 */
  hull() {
    translate([12, 71.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 71.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 14.8, length 126 */
  hull() {
    translate([12, 84.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([138, 84.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 94, -2.5]) cylinder(h = 10, d = mount_d);
  translate([135, 6, -2.5]) cylinder(h = 10, d = mount_d);
  translate([135, 94, -2.5]) cylinder(h = 10, d = mount_d);
}
