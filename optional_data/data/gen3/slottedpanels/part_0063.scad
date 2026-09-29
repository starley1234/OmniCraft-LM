$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 90;             // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 70 */
  hull() {
    translate([25, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.8, length 75 */
  hull() {
    translate([22.5, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.5, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 16.6, length 80 */
  hull() {
    translate([20, 41.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100, 41.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 18.4, length 85 */
  hull() {
    translate([17.5, 57.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.5, 57.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 20.2, length 90 */
  hull() {
    translate([15, 76.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([105, 76.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 85, -2.5]) cylinder(h = 10, d = mount_d);
  translate([105, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([105, 85, -2.5]) cylinder(h = 10, d = mount_d);
}
