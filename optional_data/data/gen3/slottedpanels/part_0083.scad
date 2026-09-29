$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 78;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 163.2 */
  hull() {
    translate([8.4, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.8, length 163.2 */
  hull() {
    translate([8.4, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 13, length 163.2 */
  hull() {
    translate([8.4, 39.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 39.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.8, length 163.2 */
  hull() {
    translate([8.4, 52.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 52.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 13, length 163.2 */
  hull() {
    translate([8.4, 67.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 67.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 14.8, length 163.2 */
  hull() {
    translate([8.4, 80.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([171.6, 80.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 95.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([168, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([168, 95.8, -2.5]) cylinder(h = 11, d = mount_d);
}
