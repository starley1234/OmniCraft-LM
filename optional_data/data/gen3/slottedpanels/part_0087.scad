$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 160 */
  hull() {
    translate([10, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.8, length 160 */
  hull() {
    translate([10, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 160 */
  hull() {
    translate([10, 36.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 36.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12.8, length 160 */
  hull() {
    translate([10, 47.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 47.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 160 */
  hull() {
    translate([10, 60.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 60.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 75, -2.5]) cylinder(h = 11, d = mount_d);
  translate([165, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([165, 75, -2.5]) cylinder(h = 11, d = mount_d);
}
