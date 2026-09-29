$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 80;             // panel depth
thick = 8;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 156 */
  hull() {
    translate([12, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.4, length 156 */
  hull() {
    translate([12, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 156 */
  hull() {
    translate([12, 36.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 36.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12.4, length 156 */
  hull() {
    translate([12, 46.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 46.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 10, length 156 */
  hull() {
    translate([12, 59.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168, 59.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([15, 74, -2.5]) cylinder(h = 13, d = mount_d);
  translate([165, 6, -2.5]) cylinder(h = 13, d = mount_d);
  translate([165, 74, -2.5]) cylinder(h = 13, d = mount_d);
}
