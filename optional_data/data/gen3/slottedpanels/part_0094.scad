$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 100 mm, 5 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 100;            // panel depth
thick = 6;                // panel thickness
slot_w = 6;               // slot width
pitch0 = 12;              // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 10;              // margin around the slot field
rows = 5;                 // number of slot rows
mount_d = 6.6;            // mounting holes
mount_x = 48;             // mounting hole offset
rim_h = 11;               // rim height
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
  /* row 0: pitch 12, length 70 */
  hull() {
    translate([25, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([95, 13, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 14.4, length 75 */
  hull() {
    translate([22.5, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([97.5, 25, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 16.8, length 80 */
  hull() {
    translate([20, 39.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([100, 39.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 19.2, length 85 */
  hull() {
    translate([17.5, 56.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.5, 56.2, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 21.6, length 90 */
  hull() {
    translate([15, 75.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([105, 75.4, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 5, -2.5]) cylinder(h = 16, d = mount_d);
  translate([12, 95, -2.5]) cylinder(h = 16, d = mount_d);
  translate([108, 5, -2.5]) cylinder(h = 16, d = mount_d);
  translate([108, 95, -2.5]) cylinder(h = 16, d = mount_d);
}
