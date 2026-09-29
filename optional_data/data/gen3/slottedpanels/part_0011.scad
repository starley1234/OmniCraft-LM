$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 200 x 70 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 200;            // panel width
panel_d = 70;             // panel depth
thick = 8;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 85;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 180.8 */
  hull() {
    translate([9.6, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190.4, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.2, length 180.8 */
  hull() {
    translate([9.6, 22.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190.4, 22.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 180.8 */
  hull() {
    translate([9.6, 33.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190.4, 33.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 11.2, length 180.8 */
  hull() {
    translate([9.6, 43.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190.4, 43.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 10, length 180.8 */
  hull() {
    translate([9.6, 55, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([190.4, 55, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.8, -2.5]) cylinder(h = 13, d = mount_d);
  translate([15, 65.2, -2.5]) cylinder(h = 13, d = mount_d);
  translate([185, 4.8, -2.5]) cylinder(h = 13, d = mount_d);
  translate([185, 65.2, -2.5]) cylinder(h = 13, d = mount_d);
}
