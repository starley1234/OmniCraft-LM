$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 88;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 180 */
  hull() {
    translate([10, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 180 */
  hull() {
    translate([10, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 180 */
  hull() {
    translate([10, 36.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 36.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.4, length 180 */
  hull() {
    translate([10, 47.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 47.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 180 */
  hull() {
    translate([10, 61.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 61.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 75, -2.5]) cylinder(h = 11, d = mount_d);
  translate([188, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([188, 75, -2.5]) cylinder(h = 11, d = mount_d);
}
