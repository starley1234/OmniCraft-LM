$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 90;             // panel depth
thick = 8;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 160 */
  hull() {
    translate([10, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.2, length 160 */
  hull() {
    translate([10, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 26.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 160 */
  hull() {
    translate([10, 40.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 40.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.2, length 160 */
  hull() {
    translate([10, 53.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 53.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 13, length 160 */
  hull() {
    translate([10, 67.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 67.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([15, 85, -2.5]) cylinder(h = 13, d = mount_d);
  translate([165, 5, -2.5]) cylinder(h = 13, d = mount_d);
  translate([165, 85, -2.5]) cylinder(h = 13, d = mount_d);
}
