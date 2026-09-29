$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 90 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 90;             // panel depth
thick = 5;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 85;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 180 */
  hull() {
    translate([10, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.4, length 180 */
  hull() {
    translate([10, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 180 */
  hull() {
    translate([10, 39.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 39.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.4, length 180 */
  hull() {
    translate([10, 51.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 51.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 12, length 180 */
  hull() {
    translate([10, 65.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 65.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 85, -2.5]) cylinder(h = 10, d = mount_d);
  translate([185, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([185, 85, -2.5]) cylinder(h = 10, d = mount_d);
}
