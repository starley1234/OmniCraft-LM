$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 70 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 70;             // panel depth
thick = 5;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
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
  /* row 0: pitch 10, length 64 */
  hull() {
    translate([58, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([122, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 10, length 83.2 */
  hull() {
    translate([48.4, 23, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([131.6, 23, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 102.4 */
  hull() {
    translate([38.8, 33, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([141.2, 33, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 10, length 121.6 */
  hull() {
    translate([29.2, 43, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([150.8, 43, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 10, length 140.8 */
  hull() {
    translate([19.6, 53, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([160.4, 53, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 65, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 65, -2.5]) cylinder(h = 10, d = mount_d);
}
