$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 150 x 100 mm, 6 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 150;            // panel width
panel_d = 100;            // panel depth
thick = 5;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 10;              // first row pitch
pitch_step = 1.2;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 6;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 60;             // mounting hole offset
rim_h = 10;               // rim height
rim_t = 4;                // rim wall thickness

difference() {
  union() {
    cube([panel_w, panel_d, thick]);
    translate([0, 0, thick - 1]) difference() {
      cube([panel_w, panel_d, rim_h - thick + 1]);
      translate([rim_t, rim_t, -2.5]) cube([panel_w - 2 * rim_t, panel_d - 2 * rim_t, rim_h - thick + 6]);
    }
  }
  /* slot rows: stadium shaped cutters, 2.5 mm clear of both faces */
  /* row 0: pitch 10, length 88.2 */
  hull() {
    translate([30.9, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([119.1, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 11.2, length 94.5 */
  hull() {
    translate([27.75, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([122.25, 24.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 12.4, length 100.8 */
  hull() {
    translate([24.6, 35.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([125.4, 35.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 13.6, length 107.1 */
  hull() {
    translate([21.45, 48.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([128.55, 48.1, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 14.8, length 113.4 */
  hull() {
    translate([18.3, 61.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([131.7, 61.7, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 16, length 113.4 */
  hull() {
    translate([18.3, 76.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([131.7, 76.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([15, 6, -2.5]) cylinder(h = 15, d = mount_d);
  translate([15, 94, -2.5]) cylinder(h = 15, d = mount_d);
  translate([135, 6, -2.5]) cylinder(h = 15, d = mount_d);
  translate([135, 94, -2.5]) cylinder(h = 15, d = mount_d);
}
