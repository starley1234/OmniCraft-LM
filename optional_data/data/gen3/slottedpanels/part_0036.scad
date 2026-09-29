$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 100 mm, 8 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 8;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 88;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 72 */
  hull() {
    translate([64, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([136, 12.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 10, length 93.6 */
  hull() {
    translate([53.2, 22.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([146.8, 22.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 115.2 */
  hull() {
    translate([42.4, 32.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([157.6, 32.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 10, length 136.8 */
  hull() {
    translate([31.6, 42.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168.4, 42.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 10, length 158.4 */
  hull() {
    translate([20.8, 52.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([179.2, 52.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 10, length 180 */
  hull() {
    translate([10, 62.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 62.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 6: pitch 10, length 180 */
  hull() {
    translate([10, 72.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 72.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 7: pitch 10, length 180 */
  hull() {
    translate([10, 82.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190, 82.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 95, -2.5]) cylinder(h = 11, d = mount_d);
  translate([188, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([188, 95, -2.5]) cylinder(h = 11, d = mount_d);
}
