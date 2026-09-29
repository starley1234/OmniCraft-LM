$fn = 32;

// ----------------------------------------------------------------------
// Slotted panel: 120 x 90 mm, 7 рядов of slots
// ----------------------------------------------------------------------

// --- parameters (mm) ---
panel_w = 120;            // panel width
panel_d = 90;             // panel depth
thick = 8;                // panel thickness
slot_w = 5;               // slot width
pitch0 = 9;               // first row pitch
pitch_step = 2.4;         // pitch increase per row
margin = 12;              // margin around the slot field
rows = 7;                 // number of slot rows
mount_d = 5.4;            // mounting holes
mount_x = 48;             // mounting hole offset
rim_h = 15;               // rim height
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
  /* row 0: pitch 9, length 38.4 */
  hull() {
    translate([40.8, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([79.2, 14.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 1: pitch 9, length 49.92 */
  hull() {
    translate([35.04, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([84.96, 23.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 2: pitch 9, length 61.44 */
  hull() {
    translate([29.28, 32.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([90.72, 32.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 3: pitch 9, length 72.96 */
  hull() {
    translate([23.52, 41.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([96.48, 41.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 4: pitch 9, length 84.48 */
  hull() {
    translate([17.76, 50.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([102.24, 50.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 5: pitch 9, length 96 */
  hull() {
    translate([12, 59.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 59.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  /* row 6: pitch 9, length 96 */
  hull() {
    translate([12, 68.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([108, 68.5, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
  translate([12, 6, -2.5]) cylinder(h = 20, d = mount_d);
  translate([12, 84, -2.5]) cylinder(h = 20, d = mount_d);
  translate([108, 6, -2.5]) cylinder(h = 20, d = mount_d);
  translate([108, 84, -2.5]) cylinder(h = 20, d = mount_d);
}
