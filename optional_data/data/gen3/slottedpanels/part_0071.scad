$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 90 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 90;             // panel depth
thick = 6;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 103.2 */
  hull() {
    translate([8.4, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 10.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 12.2, length 103.2 */
  hull() {
    translate([8.4, 21.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 21.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 103.2 */
  hull() {
    translate([8.4, 34.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 34.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 12.2, length 103.2 */
  hull() {
    translate([8.4, 45.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 45.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 103.2 */
  hull() {
    translate([8.4, 57.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 57.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 12.2, length 103.2 */
  hull() {
    translate([8.4, 68.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([111.6, 68.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 85.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 4.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 85.8, -2.5]) cylinder(h = 11, d = mount_d);
}
