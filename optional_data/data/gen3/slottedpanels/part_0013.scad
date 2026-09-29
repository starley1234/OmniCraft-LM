$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 88;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 72 */
  hull() {
    translate([64, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([136, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11, length 93.6 */
  hull() {
    translate([53.2, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([146.8, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 115.2 */
  hull() {
    translate([42.4, 35, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([157.6, 35, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11, length 136.8 */
  hull() {
    translate([31.6, 46, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([168.4, 46, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 158.4 */
  hull() {
    translate([20.8, 57, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([179.2, 57, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 65, -2.5]) cylinder(h = 11, d = mount_d);
  translate([188, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([188, 65, -2.5]) cylinder(h = 11, d = mount_d);
}
