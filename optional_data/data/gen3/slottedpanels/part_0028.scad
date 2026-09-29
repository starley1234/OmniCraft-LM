$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 1.8;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 100 */
  hull() {
    translate([10, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 13.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.8, length 100 */
  hull() {
    translate([10, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 25.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 100 */
  hull() {
    translate([10, 39.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 39.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.8, length 100 */
  hull() {
    translate([10, 51.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 51.3, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 12, length 100 */
  hull() {
    translate([10, 65.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 65.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 13.8, length 100 */
  hull() {
    translate([10, 77.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110, 77.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 95, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 5, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 95, -2.5]) cylinder(h = 11, d = mount_d);
}
