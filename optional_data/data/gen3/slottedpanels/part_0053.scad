$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 80 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 80;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 48;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 96 */
  hull() {
    translate([12, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 15, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 96 */
  hull() {
    translate([12, 26, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 26, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 96 */
  hull() {
    translate([12, 39.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 39.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.4, length 96 */
  hull() {
    translate([12, 50.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 50.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 96 */
  hull() {
    translate([12, 63.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 63.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 74, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 6, -2.5]) cylinder(h = 11, d = mount_d);
  translate([108, 74, -2.5]) cylinder(h = 11, d = mount_d);
}
