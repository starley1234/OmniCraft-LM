$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 100 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 100;            // panel depth
thick = 5;                // panel thickness
slot_w = 7;               // slot width
pitch0 = 13;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 8.4;             // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 45;             // mounting hole offset
rim_h = 10;               // rim height
rim_t = 3;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 13, length 72.24 */
  hull() {
    translate([23.88, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([96.12, 11.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.2, length 77.4 */
  hull() {
    translate([21.3, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([98.7, 24.9, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 15.4, length 82.56 */
  hull() {
    translate([18.72, 39.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([101.28, 39.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 16.6, length 87.72 */
  hull() {
    translate([16.14, 54.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([103.86, 54.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 17.8, length 92.88 */
  hull() {
    translate([13.56, 71.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([106.44, 71.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.2, -2.5]) cylinder(h = 15, d = mount_d);
  translate([15, 95.8, -2.5]) cylinder(h = 15, d = mount_d);
  translate([105, 4.2, -2.5]) cylinder(h = 15, d = mount_d);
  translate([105, 95.8, -2.5]) cylinder(h = 15, d = mount_d);
}
