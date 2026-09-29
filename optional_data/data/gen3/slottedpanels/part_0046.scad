$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 70 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 70;             // panel depth
thick = 5;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 163.2 */
  hull() {
    translate([8.4, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.4, length 163.2 */
  hull() {
    translate([8.4, 20.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 20.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 10, length 163.2 */
  hull() {
    translate([8.4, 33.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 33.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12.4, length 163.2 */
  hull() {
    translate([8.4, 43.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 43.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 10, length 163.2 */
  hull() {
    translate([8.4, 55.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 55.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 65.8, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 4.2, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 65.8, -2.5]) cylinder(h = 10, d = mount_d);
}
