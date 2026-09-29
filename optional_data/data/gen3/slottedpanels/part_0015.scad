$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 90 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 90;             // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 9.6;             // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 45;             // mounting hole offset

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 12, length 100.8 */
  hull() {
    translate([9.6, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110.4, 12.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.4, length 100.8 */
  hull() {
    translate([9.6, 24.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110.4, 24.6, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12, length 100.8 */
  hull() {
    translate([9.6, 39, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110.4, 39, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 14.4, length 100.8 */
  hull() {
    translate([9.6, 51, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110.4, 51, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 12, length 100.8 */
  hull() {
    translate([9.6, 65.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110.4, 65.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 14.4, length 100.8 */
  hull() {
    translate([9.6, 77.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([110.4, 77.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([15, 85.2, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 4.8, -2.5]) cylinder(h = 11, d = mount_d);
  translate([105, 85.2, -2.5]) cylinder(h = 11, d = mount_d);
}
