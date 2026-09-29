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
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 60;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 130 */
  hull() {
    translate([10, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 15.4, length 130 */
  hull() {
    translate([10, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 130 */
  hull() {
    translate([10, 41.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140, 41.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 15.4, length 130 */
  hull() {
    translate([10, 54.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140, 54.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 13, length 130 */
  hull() {
    translate([10, 70.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140, 70.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 15.4, length 130 */
  hull() {
    translate([10, 83.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([140, 83.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 95, -2.5]) cylinder(h = 10, d = mount_d);
  translate([135, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([135, 95, -2.5]) cylinder(h = 10, d = mount_d);
}
