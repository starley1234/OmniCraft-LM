$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 160.8 */
  hull() {
    translate([9.6, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170.4, 13.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 160.8 */
  hull() {
    translate([9.6, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170.4, 24.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 160.8 */
  hull() {
    translate([9.6, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170.4, 37.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.4, length 160.8 */
  hull() {
    translate([9.6, 48.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170.4, 48.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 160.8 */
  hull() {
    translate([9.6, 61.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170.4, 61.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 75.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([165, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([165, 75.2, -2.5]) cylinder(h = 11, d = mount_d);
}
