$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 180 x 90 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 180;            // panel width
panel_d = 90;             // panel depth
thick = 5;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 11;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 75;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 11, length 160 */
  hull() {
    translate([10, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 13.4, length 160 */
  hull() {
    translate([10, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 24, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 11, length 160 */
  hull() {
    translate([10, 37.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 37.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.4, length 160 */
  hull() {
    translate([10, 48.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 48.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 11, length 160 */
  hull() {
    translate([10, 61.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 61.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 13.4, length 160 */
  hull() {
    translate([10, 72.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([170, 72.8, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([15, 85, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 5, -2.5]) cylinder(h = 10, d = mount_d);
  translate([165, 85, -2.5]) cylinder(h = 10, d = mount_d);
}
