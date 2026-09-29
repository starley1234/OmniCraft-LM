$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 11;              // first row pitch
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
  /* row 0: pitch 11, length 114.24 */
  hull() {
    translate([32.88, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([147.12, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.8, length 122.4 */
  hull() {
    translate([28.8, 21.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([151.2, 21.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 14.6, length 130.56 */
  hull() {
    translate([24.72, 34.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([155.28, 34.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 16.4, length 138.72 */
  hull() {
    translate([20.64, 49.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([159.36, 49.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 18.2, length 146.88 */
  hull() {
    translate([16.56, 65.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([163.44, 65.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 20, length 146.88 */
  hull() {
    translate([16.56, 83.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([163.44, 83.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([12, 95.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([168, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([168, 95.8, -2.5]) cylinder(h = 11, d = mount_d);
}
